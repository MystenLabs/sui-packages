module 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card {
    struct CARD has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SudoCard has store, key {
        id: 0x2::object::UID,
        number: u16,
        tier: u8,
        level: u16,
        points: u64,
    }

    struct CardRegistry has key {
        id: 0x2::object::UID,
        cards: 0x2::table::Table<0x2::object::ID, u16>,
    }

    struct CardTracker has key {
        id: 0x2::object::UID,
        tier: u8,
        current_count: u16,
        max_count: u16,
    }

    struct Points has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct MintSettings has key {
        id: 0x2::object::UID,
        public_mint_price: u64,
        mint_ticket_mint_price: u64,
    }

    struct MintTicket has store, key {
        id: 0x2::object::UID,
        tier: u8,
        initial_points: u64,
        expiration_epoch: u64,
    }

    struct DestroyPointsCap {
        points_id: 0x2::object::ID,
    }

    struct Minted has copy, drop {
        id: 0x2::object::ID,
        tier: u8,
        minter: address,
    }

    struct PointsCreated has copy, drop {
        id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
    }

    struct PointsRedeemed has copy, drop {
        card: 0x2::object::ID,
        amount: u64,
    }

    struct PointsDestroyed has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
    }

    struct LevelUp has copy, drop {
        card: 0x2::object::ID,
        old_level: u16,
        new_level: u16,
    }

    struct TokenClaimed<phantom T0> has copy, drop {
        card: 0x2::object::ID,
        claimed_amount: u64,
        receiver: address,
    }

    public fun receive<T0: store + key>(arg0: &mut SudoCard, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun add_points(arg0: &mut SudoCard, arg1: Points) {
        arg0.points = arg0.points + arg1.amount;
        internal_destroy_points(arg1);
    }

    public fun admin_create_points(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Points{
            id     : 0x2::object::new(arg3),
            amount : arg1,
        };
        let v1 = PointsCreated{
            id          : 0x2::object::id<Points>(&v0),
            beneficiary : arg2,
            amount      : arg1,
        };
        0x2::event::emit<PointsCreated>(v1);
        0x2::transfer::transfer<Points>(v0, arg2);
    }

    public fun admin_issue_mint_ticket(arg0: &AdminCap, arg1: u8, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0 && arg1 <= 2, 8);
        let v0 = MintTicket{
            id               : 0x2::object::new(arg4),
            tier             : arg1,
            initial_points   : arg3,
            expiration_epoch : 0x2::tx_context::epoch(arg4) + 30,
        };
        0x2::transfer::transfer<MintTicket>(v0, arg2);
    }

    public fun admin_mint(arg0: &AdminCap, arg1: u8, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg7: &mut CardTracker, arg8: &mut CardRegistry, arg9: &mut 0x2::tx_context::TxContext) {
        assert!((0x2::table::length<0x2::object::ID, u16>(&arg8.cards) as u16) < 2222, 5);
        assert!(arg7.tier == arg1, 10);
        assert!(arg7.current_count < arg7.max_count, 7);
        mint(arg3, arg2, arg1, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun admin_update_card_tracker_max_count(arg0: &AdminCap, arg1: &mut CardTracker, arg2: u16) {
        arg1.max_count = arg2;
    }

    public fun admin_update_mint_settings(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &mut MintSettings) {
        arg3.public_mint_price = arg1;
        arg3.mint_ticket_mint_price = arg2;
    }

    public fun claim_token<T0>(arg0: &mut SudoCard, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = receive_token<T0>(arg0, arg1);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = 0x2::tx_context::sender(arg2);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
            let v3 = TokenClaimed<T0>{
                card           : 0x2::object::id<SudoCard>(arg0),
                claimed_amount : v1,
                receiver       : v2,
            };
            0x2::event::emit<TokenClaimed<T0>>(v3);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    fun destroy_redeemed_points(arg0: Points, arg1: DestroyPointsCap) {
        assert!(arg1.points_id == 0x2::object::id<Points>(&arg0), 4);
        let v0 = PointsDestroyed{
            id     : 0x2::object::id<Points>(&arg0),
            amount : arg0.amount,
        };
        0x2::event::emit<PointsDestroyed>(v0);
        internal_destroy_points(arg0);
        let DestroyPointsCap {  } = arg1;
    }

    public fun get_level(arg0: &SudoCard) : u16 {
        arg0.level
    }

    public fun get_tier(arg0: &SudoCard) : u8 {
        arg0.tier
    }

    fun init(arg0: CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CARD>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = MintSettings{
            id                     : 0x2::object::new(arg1),
            public_mint_price      : 30000000000,
            mint_ticket_mint_price : 20000000000,
        };
        let v3 = 0;
        while (v3 < 3) {
            let v4 = CardTracker{
                id            : 0x2::object::new(arg1),
                tier          : v3,
                current_count : 0,
                max_count     : max_count_for_tier(v3),
            };
            0x2::transfer::share_object<CardTracker>(v4);
            v3 = v3 + 1;
        };
        let v5 = CardRegistry{
            id    : 0x2::object::new(arg1),
            cards : 0x2::table::new<0x2::object::ID, u16>(arg1),
        };
        0x2::transfer::share_object<CardRegistry>(v5);
        let v6 = 0x2::display::new<SudoCard>(&v0, arg1);
        0x2::display::add<SudoCard>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Sudo Membership Card #{number}"));
        0x2::display::add<SudoCard>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A membership card for the Sudo platform."));
        0x2::display::add<SudoCard>(&mut v6, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://www.sudo.finance/"));
        0x2::display::add<SudoCard>(&mut v6, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://scard.sudo.finance/"));
        0x2::display::add<SudoCard>(&mut v6, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Sudo Finance x Studio Mirai"));
        0x2::display::add<SudoCard>(&mut v6, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<SudoCard>(&mut v6, 0x1::string::utf8(b"tier"), 0x1::string::utf8(b"{tier}"));
        0x2::display::add<SudoCard>(&mut v6, 0x1::string::utf8(b"points"), 0x1::string::utf8(b"{points}"));
        0x2::display::add<SudoCard>(&mut v6, 0x1::string::utf8(b"level"), 0x1::string::utf8(b"{level}"));
        0x2::display::add<SudoCard>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://img.sudo.finance/{id}.webp"));
        0x2::display::update_version<SudoCard>(&mut v6);
        let v7 = 0x2::display::new<MintTicket>(&v0, arg1);
        0x2::display::add<MintTicket>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"S Card Mint Ticket"));
        0x2::display::add<MintTicket>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A mint ticket for the Sudo membership card"));
        0x2::display::add<MintTicket>(&mut v7, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://www.sudo.finance/"));
        0x2::display::add<MintTicket>(&mut v7, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://scard.sudo.finance/"));
        0x2::display::add<MintTicket>(&mut v7, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Sudo Finance x Studio Mirai"));
        0x2::display::add<MintTicket>(&mut v7, 0x1::string::utf8(b"tier"), 0x1::string::utf8(b"{tier}"));
        0x2::display::add<MintTicket>(&mut v7, 0x1::string::utf8(b"initial_points"), 0x1::string::utf8(b"{initial_points}"));
        0x2::display::add<MintTicket>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://s3.ap-northeast-1.amazonaws.com/img.sudo.finance/1.png"));
        0x2::display::update_version<MintTicket>(&mut v7);
        let (v8, v9) = 0x2::transfer_policy::new<SudoCard>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SudoCard>>(v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SudoCard>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SudoCard>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MintTicket>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintSettings>(v2);
    }

    fun internal_destroy_points(arg0: Points) {
        let Points {
            id     : v0,
            amount : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun level_up(arg0: &mut SudoCard, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = points_needed_for_level_up(arg0);
        assert!(arg0.points >= v0, 3);
        redeem_points(arg0, v0, arg1);
        let v1 = arg0.level;
        let v2 = v1 + 1;
        arg0.level = v2;
        let v3 = LevelUp{
            card      : 0x2::object::id<SudoCard>(arg0),
            old_level : v1,
            new_level : v2,
        };
        0x2::event::emit<LevelUp>(v3);
    }

    fun max_count_for_tier(arg0: u8) : u16 {
        if (arg0 == 0) {
            136
        } else if (arg0 == 1) {
            600
        } else if (arg0 == 2) {
            1486
        } else {
            0
        }
    }

    fun mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u8, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg6: &mut CardTracker, arg7: &mut CardRegistry, arg8: &mut 0x2::tx_context::TxContext) {
        arg6.current_count = arg6.current_count + 1;
        let v0 = SudoCard{
            id     : 0x2::object::new(arg8),
            number : arg6.current_count,
            tier   : arg2,
            level  : 0,
            points : arg1,
        };
        0x2::table::add<0x2::object::ID, u16>(&mut arg7.cards, 0x2::object::id<SudoCard>(&v0), arg6.current_count);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x1a21219e7935fd8231b19f432f0ee0c5f8d273dbb244313e5c80dda433b68912);
        let v1 = Minted{
            id     : 0x2::object::id<SudoCard>(&v0),
            tier   : arg2,
            minter : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<Minted>(v1);
        0x2::kiosk::lock<SudoCard>(arg3, arg4, arg5, v0);
    }

    public fun mint_with_mint_ticket(arg0: MintTicket, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg5: &mut CardTracker, arg6: &mut CardRegistry, arg7: &MintSettings, arg8: &mut 0x2::tx_context::TxContext) {
        let MintTicket {
            id               : v0,
            tier             : v1,
            initial_points   : v2,
            expiration_epoch : v3,
        } = arg0;
        assert!(0x2::tx_context::epoch(arg8) < v3, 9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg7.mint_ticket_mint_price, 1);
        assert!((0x2::table::length<0x2::object::ID, u16>(&arg6.cards) as u16) <= 2222, 5);
        assert!(arg5.tier == v1, 6);
        assert!(arg5.current_count < arg5.max_count, 7);
        mint(arg1, v2, v1, arg2, arg3, arg4, arg5, arg6, arg8);
        0x2::object::delete(v0);
    }

    fun points_needed_for_level_up(arg0: &SudoCard) : u64 {
        let v0 = (arg0.level as u64);
        1000 + 2000 * v0 * v0
    }

    public fun public_mint_silver_card(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg4: &mut CardTracker, arg5: &mut CardRegistry, arg6: &MintSettings, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg6.public_mint_price, 1);
        assert!((0x2::table::length<0x2::object::ID, u16>(&arg5.cards) as u16) < 2222, 5);
        assert!(arg4.tier == 2, 10);
        assert!(arg4.current_count < arg4.max_count, 7);
        mint(arg0, 0, 2, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public fun receive_points(arg0: &mut SudoCard, arg1: 0x2::transfer::Receiving<Points>) : Points {
        0x2::transfer::receive<Points>(&mut arg0.id, arg1)
    }

    public fun receive_token<T0>(arg0: &mut SudoCard, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)
    }

    public fun redeem_points(arg0: &mut SudoCard, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.points >= arg1, 2);
        arg0.points = arg0.points - arg1;
        let v0 = Points{
            id     : 0x2::object::new(arg2),
            amount : arg1,
        };
        let v1 = DestroyPointsCap{points_id: 0x2::object::id<Points>(&v0)};
        let v2 = PointsRedeemed{
            card   : 0x2::object::id<SudoCard>(arg0),
            amount : arg1,
        };
        0x2::event::emit<PointsRedeemed>(v2);
        destroy_redeemed_points(v0, v1);
    }

    // decompiled from Move bytecode v6
}

