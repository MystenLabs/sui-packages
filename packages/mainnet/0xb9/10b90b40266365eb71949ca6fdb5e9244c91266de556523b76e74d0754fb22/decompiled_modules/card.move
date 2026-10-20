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

    struct ZPoints has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct ZPointsBalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MintSettings has key {
        id: 0x2::object::UID,
        public_mint_price: u64,
        mint_ticket_mint_price: u64,
    }

    struct PackageControl has copy, drop, store {
        version: u64,
        function_mask: u128,
    }

    struct PackageControlKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TierMintPrice has copy, drop, store {
        public_mint_price: u64,
        mint_ticket_mint_price: u64,
    }

    struct TierMintPriceKey has copy, drop, store {
        tier: u8,
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

    struct ZPointsCreated has copy, drop {
        id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
    }

    struct ZPointsAdded has copy, drop {
        card: 0x2::object::ID,
        amount: u64,
    }

    struct ZPointsRedeemed has copy, drop {
        card: 0x2::object::ID,
        points_id: 0x2::object::ID,
        amount: u64,
    }

    struct ZPointsJoined has copy, drop {
        id: 0x2::object::ID,
        other_id: 0x2::object::ID,
        amount: u64,
    }

    struct ZPointsSplit has copy, drop {
        id: 0x2::object::ID,
        new_id: 0x2::object::ID,
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

    struct PackageControlInitialized has copy, drop {
        version: u64,
        function_mask: u128,
    }

    struct PackageVersionMigrated has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct FunctionMaskUpdated has copy, drop {
        function_mask: u128,
    }

    struct FunctionEnabledSet has copy, drop {
        function_index: u8,
        enabled: bool,
        function_mask: u128,
    }

    struct TierMintPriceUpdated has copy, drop {
        tier: u8,
        public_mint_price: u64,
        mint_ticket_mint_price: u64,
    }

    public fun receive<T0: store + key>(arg0: &mut SudoCard, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public(friend) fun add_admin_field<T0: copy + drop + store, T1: store>(arg0: &mut AdminCap, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    fun add_package_control(arg0: &mut 0x2::object::UID) {
        let v0 = PackageControlKey{dummy_field: false};
        let v1 = PackageControl{
            version       : 1,
            function_mask : 255,
        };
        0x2::dynamic_field::add<PackageControlKey, PackageControl>(arg0, v0, v1);
    }

    public fun add_points(arg0: &mut SudoCard, arg1: Points) {
        arg0.points = arg0.points + arg1.amount;
        internal_destroy_points(arg1);
    }

    public fun add_z_points(arg0: &mut SudoCard, arg1: ZPoints) {
        let v0 = 0x2::object::id<SudoCard>(arg0);
        let ZPoints {
            id     : v1,
            amount : v2,
        } = arg1;
        let v3 = z_points_balance_mut(arg0);
        *v3 = *v3 + v2;
        0x2::object::delete(v1);
        let v4 = ZPointsAdded{
            card   : v0,
            amount : v2,
        };
        0x2::event::emit<ZPointsAdded>(v4);
    }

    public fun admin_create_points(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_function(arg0, 0);
        0x2::transfer::transfer<Points>(create_points(arg1, arg2, arg3), arg2);
    }

    public(friend) fun admin_has_field<T0: copy + drop + store>(arg0: &AdminCap, arg1: T0) : bool {
        0x2::dynamic_field::exists<T0>(&arg0.id, arg1)
    }

    public fun admin_init_package_control(arg0: &mut AdminCap, arg1: &mut MintSettings) {
        assert!(!package_control_exists(&arg0.id), 14);
        assert!(!package_control_exists(&arg1.id), 14);
        let v0 = &mut arg0.id;
        add_package_control(v0);
        let v1 = &mut arg1.id;
        add_package_control(v1);
        let v2 = PackageControlInitialized{
            version       : 1,
            function_mask : 255,
        };
        0x2::event::emit<PackageControlInitialized>(v2);
    }

    public fun admin_issue_mint_ticket(arg0: &AdminCap, arg1: u8, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin_function(arg0, 3);
        assert!(arg1 >= 0 && arg1 <= 2, 8);
        let v0 = MintTicket{
            id               : 0x2::object::new(arg4),
            tier             : arg1,
            initial_points   : arg3,
            expiration_epoch : 0x2::tx_context::epoch(arg4) + 30,
        };
        0x2::transfer::transfer<MintTicket>(v0, arg2);
    }

    public fun admin_migrate_package_version(arg0: &mut AdminCap, arg1: &mut MintSettings) {
        assert!(package_control_exists(&arg0.id), 15);
        assert!(package_control_exists(&arg1.id), 15);
        let v0 = package_version_of(&arg0.id);
        let v1 = function_mask_of(&arg0.id);
        assert!(v0 == 1 || v0 < 1 && 1 - v0 == 1, 12);
        write_package_control(arg0, arg1, 1, v1);
        let v2 = PackageVersionMigrated{
            old_version : v0,
            new_version : 1,
        };
        0x2::event::emit<PackageVersionMigrated>(v2);
    }

    public fun admin_mint(arg0: &AdminCap, arg1: u8, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg7: &mut CardTracker, arg8: &mut CardRegistry, arg9: &mut 0x2::tx_context::TxContext) {
        assert_admin_function(arg0, 4);
        assert!((0x2::table::length<0x2::object::ID, u16>(&arg8.cards) as u16) < 2222, 5);
        assert!(arg7.tier == arg1, 10);
        assert!(arg7.current_count < arg7.max_count, 7);
        mint(arg3, arg2, arg1, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun admin_set_function_enabled(arg0: &mut AdminCap, arg1: &mut MintSettings, arg2: u8, arg3: bool) {
        assert_package_version(&arg0.id);
        assert_package_version(&arg1.id);
        assert!(arg2 < 128, 16);
        let v0 = update_mask(function_mask_of(&arg0.id), arg2, arg3);
        write_package_control(arg0, arg1, 1, v0);
        let v1 = FunctionEnabledSet{
            function_index : arg2,
            enabled        : arg3,
            function_mask  : v0,
        };
        0x2::event::emit<FunctionEnabledSet>(v1);
    }

    public fun admin_set_function_mask(arg0: &mut AdminCap, arg1: &mut MintSettings, arg2: u128) {
        assert_package_version(&arg0.id);
        assert_package_version(&arg1.id);
        write_package_control(arg0, arg1, 1, arg2);
        let v0 = FunctionMaskUpdated{function_mask: arg2};
        0x2::event::emit<FunctionMaskUpdated>(v0);
    }

    public fun admin_set_tier_mint_price(arg0: &AdminCap, arg1: &mut MintSettings, arg2: u8, arg3: u64, arg4: u64) {
        assert_admin_function(arg0, 7);
        assert!(arg2 >= 0 && arg2 <= 2, 8);
        set_tier_mint_price(arg1, arg2, arg3, arg4);
    }

    public fun admin_update_card_tracker_max_count(arg0: &AdminCap, arg1: &mut CardTracker, arg2: u16) {
        assert_admin_function(arg0, 2);
        arg1.max_count = arg2;
    }

    public fun admin_update_mint_settings(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &mut MintSettings) {
        assert_admin_function(arg0, 1);
        arg3.public_mint_price = arg1;
        arg3.mint_ticket_mint_price = arg2;
    }

    public(friend) fun assert_admin_enabled(arg0: &AdminCap, arg1: u8) {
        assert_admin_function(arg0, arg1);
    }

    fun assert_admin_function(arg0: &AdminCap, arg1: u8) {
        assert_function(&arg0.id, arg1);
    }

    fun assert_function(arg0: &0x2::object::UID, arg1: u8) {
        if (!package_control_exists(arg0)) {
            return
        };
        assert_function_strict(arg0, arg1);
    }

    fun assert_function_strict(arg0: &0x2::object::UID, arg1: u8) {
        assert_package_version(arg0);
        assert!(function_bit_set(function_mask_of(arg0), arg1), 13);
    }

    fun assert_package_version(arg0: &0x2::object::UID) {
        assert!(package_control_exists(arg0), 15);
        assert!(package_version_of(arg0) == 1, 12);
    }

    public(friend) fun assert_settings_enabled(arg0: &MintSettings, arg1: u8) {
        assert_settings_function(arg0, arg1);
    }

    fun assert_settings_function(arg0: &MintSettings, arg1: u8) {
        assert_function(&arg0.id, arg1);
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

    public(friend) fun create_points(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Points {
        let v0 = Points{
            id     : 0x2::object::new(arg2),
            amount : arg0,
        };
        let v1 = PointsCreated{
            id          : 0x2::object::id<Points>(&v0),
            beneficiary : arg1,
            amount      : arg0,
        };
        0x2::event::emit<PointsCreated>(v1);
        v0
    }

    public(friend) fun create_z_points(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : ZPoints {
        let v0 = ZPoints{
            id     : 0x2::object::new(arg2),
            amount : arg0,
        };
        let v1 = ZPointsCreated{
            id          : 0x2::object::id<ZPoints>(&v0),
            beneficiary : arg1,
            amount      : arg0,
        };
        0x2::event::emit<ZPointsCreated>(v1);
        v0
    }

    public fun current_package_version() : u64 {
        1
    }

    public(friend) fun debit_points(arg0: &mut Points, arg1: u64) {
        assert!(arg1 <= arg0.amount, 31);
        arg0.amount = arg0.amount - arg1;
    }

    public(friend) fun debit_z_points(arg0: &mut ZPoints, arg1: u64) {
        assert!(arg1 <= arg0.amount, 31);
        arg0.amount = arg0.amount - arg1;
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

    public fun destroy_zero_points(arg0: Points) {
        let Points {
            id     : v0,
            amount : v1,
        } = arg0;
        assert!(v1 == 0, 31);
        0x2::object::delete(v0);
    }

    public fun destroy_zero_z_points(arg0: ZPoints) {
        let ZPoints {
            id     : v0,
            amount : v1,
        } = arg0;
        assert!(v1 == 0, 31);
        0x2::object::delete(v0);
    }

    fun function_bit_set(arg0: u128, arg1: u8) : bool {
        assert!(arg1 < 128, 16);
        let v0 = 1 << arg1;
        arg0 & v0 == v0
    }

    public fun function_mask(arg0: &MintSettings) : u128 {
        if (package_control_exists(&arg0.id)) {
            function_mask_of(&arg0.id)
        } else {
            255
        }
    }

    fun function_mask_of(arg0: &0x2::object::UID) : u128 {
        let v0 = PackageControlKey{dummy_field: false};
        0x2::dynamic_field::borrow<PackageControlKey, PackageControl>(arg0, v0).function_mask
    }

    public fun get_level(arg0: &SudoCard) : u16 {
        arg0.level
    }

    public fun get_tier(arg0: &SudoCard) : u8 {
        arg0.tier
    }

    public fun has_tier_mint_price(arg0: &MintSettings, arg1: u8) : bool {
        let v0 = TierMintPriceKey{tier: arg1};
        0x2::dynamic_field::exists<TierMintPriceKey>(&arg0.id, v0)
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
        let v10 = &mut v1.id;
        add_package_control(v10);
        let v11 = &mut v2.id;
        add_package_control(v11);
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

    public fun is_function_enabled(arg0: &MintSettings, arg1: u8) : bool {
        if (arg1 >= 128) {
            return false
        };
        if (!package_control_exists(&arg0.id)) {
            return arg1 < 8
        };
        package_version_of(&arg0.id) == 1 && function_bit_set(function_mask_of(&arg0.id), arg1)
    }

    public fun join_z_points(arg0: &mut ZPoints, arg1: ZPoints) {
        let ZPoints {
            id     : v0,
            amount : v1,
        } = arg1;
        let v2 = v0;
        arg0.amount = arg0.amount + v1;
        0x2::object::delete(v2);
        let v3 = ZPointsJoined{
            id       : 0x2::object::id<ZPoints>(arg0),
            other_id : 0x2::object::uid_to_inner(&v2),
            amount   : v1,
        };
        0x2::event::emit<ZPointsJoined>(v3);
    }

    public fun level_up(arg0: &mut SudoCard, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = points_needed_for_level_up(arg0);
        assert!(arg0.points >= v0, 3);
        assert!(arg0.level < 25, 11);
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

    public fun level_up_with_z_points(arg0: &mut SudoCard) {
        let v0 = points_needed_for_level_up(arg0);
        let v1 = arg0.level;
        assert!(v1 < 25, 11);
        let v2 = 0x2::object::id<SudoCard>(arg0);
        let v3 = z_points_balance_mut(arg0);
        assert!(*v3 >= v0, 3);
        *v3 = *v3 - v0;
        let v4 = v1 + 1;
        arg0.level = v4;
        let v5 = LevelUp{
            card      : v2,
            old_level : v1,
            new_level : v4,
        };
        0x2::event::emit<LevelUp>(v5);
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

    fun mint_public_at_tier_price(arg0: u8, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg6: &mut CardTracker, arg7: &mut CardRegistry, arg8: &MintSettings, arg9: &mut 0x2::tx_context::TxContext) {
        assert_function_strict(&arg8.id, arg1);
        assert!(arg0 >= 0 && arg0 <= 2, 8);
        assert!(has_tier_mint_price(arg8, arg0), 17);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == tier_public_mint_price(arg8, arg0), 1);
        assert!((0x2::table::length<0x2::object::ID, u16>(&arg7.cards) as u16) < 2222, 5);
        assert!(arg6.tier == arg0, 10);
        assert!(arg6.current_count < arg6.max_count, 7);
        mint(arg2, 0, arg0, arg3, arg4, arg5, arg6, arg7, arg9);
    }

    public fun mint_with_mint_ticket(arg0: MintTicket, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg5: &mut CardTracker, arg6: &mut CardRegistry, arg7: &MintSettings, arg8: &mut 0x2::tx_context::TxContext) {
        assert_settings_function(arg7, 6);
        let MintTicket {
            id               : v0,
            tier             : v1,
            initial_points   : v2,
            expiration_epoch : v3,
        } = arg0;
        assert!(380 < v3, 9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == tier_mint_ticket_mint_price(arg7, v1), 1);
        assert!((0x2::table::length<0x2::object::ID, u16>(&arg6.cards) as u16) <= 2222, 5);
        assert!(arg5.tier == v1, 6);
        assert!(arg5.current_count < arg5.max_count, 7);
        mint(arg1, v2, v1, arg2, arg3, arg4, arg5, arg6, arg8);
        0x2::object::delete(v0);
    }

    public fun openLootbox<T0>(arg0: &mut SudoCard, arg1: &mut 0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::LootboxTreasury, arg2: 0x2::transfer::Receiving<0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::Lootbox>, arg3: &0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::LootboxSettings, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::open_lootbox_public<T0>(arg1, receive<0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::Lootbox>(arg0, arg2), arg4, arg3, arg5);
    }

    public fun openLootboxWithAmount<T0>(arg0: &mut SudoCard, arg1: &mut 0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::LootboxTreasury, arg2: 0x2::transfer::Receiving<0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::LootboxWithAmount<T0>>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::open_lootbox_with_amount_public<T0>(arg1, receive<0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::LootboxWithAmount<T0>>(arg0, arg2), arg3, arg4);
    }

    fun package_control_exists(arg0: &0x2::object::UID) : bool {
        let v0 = PackageControlKey{dummy_field: false};
        0x2::dynamic_field::exists<PackageControlKey>(arg0, v0)
    }

    public fun package_control_initialized(arg0: &MintSettings) : bool {
        package_control_exists(&arg0.id)
    }

    public fun package_version(arg0: &MintSettings) : u64 {
        if (package_control_exists(&arg0.id)) {
            package_version_of(&arg0.id)
        } else {
            0
        }
    }

    fun package_version_of(arg0: &0x2::object::UID) : u64 {
        let v0 = PackageControlKey{dummy_field: false};
        0x2::dynamic_field::borrow<PackageControlKey, PackageControl>(arg0, v0).version
    }

    public fun points_amount(arg0: &Points) : u64 {
        arg0.amount
    }

    fun points_needed_for_level_up(arg0: &SudoCard) : u64 {
        let v0 = (arg0.level as u64);
        1000 + 2000 * v0 * v0
    }

    public fun public_mint(arg0: u8, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg5: &mut CardTracker, arg6: &mut CardRegistry, arg7: &MintSettings, arg8: &mut 0x2::tx_context::TxContext) {
        mint_public_at_tier_price(arg0, 8, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun public_mint_black_card(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg4: &mut CardTracker, arg5: &mut CardRegistry, arg6: &MintSettings, arg7: &mut 0x2::tx_context::TxContext) {
        mint_public_at_tier_price(0, 9, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun public_mint_emerald_card(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg4: &mut CardTracker, arg5: &mut CardRegistry, arg6: &MintSettings, arg7: &mut 0x2::tx_context::TxContext) {
        mint_public_at_tier_price(1, 10, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun public_mint_silver_card(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<SudoCard>, arg4: &mut CardTracker, arg5: &mut CardRegistry, arg6: &MintSettings, arg7: &mut 0x2::tx_context::TxContext) {
        assert_settings_function(arg6, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == tier_public_mint_price(arg6, 2), 1);
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

    public fun receive_z_points(arg0: &mut SudoCard, arg1: 0x2::transfer::Receiving<ZPoints>) : ZPoints {
        0x2::transfer::receive<ZPoints>(&mut arg0.id, arg1)
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

    public fun redeem_z_points(arg0: &mut SudoCard, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ZPoints {
        assert!(arg1 > 0, 31);
        let v0 = 0x2::object::id<SudoCard>(arg0);
        let v1 = z_points_balance_mut(arg0);
        assert!(*v1 >= arg1, 31);
        *v1 = *v1 - arg1;
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = create_z_points(arg1, v2, arg2);
        let v4 = ZPointsRedeemed{
            card      : v0,
            points_id : 0x2::object::id<ZPoints>(&v3),
            amount    : arg1,
        };
        0x2::event::emit<ZPointsRedeemed>(v4);
        v3
    }

    fun set_tier_mint_price(arg0: &mut MintSettings, arg1: u8, arg2: u64, arg3: u64) {
        let v0 = TierMintPriceKey{tier: arg1};
        if (0x2::dynamic_field::exists<TierMintPriceKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<TierMintPriceKey, TierMintPrice>(&mut arg0.id, v0);
            v1.public_mint_price = arg2;
            v1.mint_ticket_mint_price = arg3;
        } else {
            let v2 = TierMintPrice{
                public_mint_price      : arg2,
                mint_ticket_mint_price : arg3,
            };
            0x2::dynamic_field::add<TierMintPriceKey, TierMintPrice>(&mut arg0.id, v0, v2);
        };
        let v3 = TierMintPriceUpdated{
            tier                   : arg1,
            public_mint_price      : arg2,
            mint_ticket_mint_price : arg3,
        };
        0x2::event::emit<TierMintPriceUpdated>(v3);
    }

    public fun split_z_points(arg0: &mut ZPoints, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ZPoints {
        assert!(arg1 > 0 && arg1 <= arg0.amount, 31);
        arg0.amount = arg0.amount - arg1;
        let v0 = ZPoints{
            id     : 0x2::object::new(arg2),
            amount : arg1,
        };
        let v1 = ZPointsSplit{
            id     : 0x2::object::id<ZPoints>(arg0),
            new_id : 0x2::object::id<ZPoints>(&v0),
            amount : arg1,
        };
        0x2::event::emit<ZPointsSplit>(v1);
        v0
    }

    public fun tier_mint_ticket_mint_price(arg0: &MintSettings, arg1: u8) : u64 {
        let v0 = TierMintPriceKey{tier: arg1};
        if (0x2::dynamic_field::exists<TierMintPriceKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<TierMintPriceKey, TierMintPrice>(&arg0.id, v0).mint_ticket_mint_price
        } else {
            arg0.mint_ticket_mint_price
        }
    }

    public fun tier_public_mint_price(arg0: &MintSettings, arg1: u8) : u64 {
        let v0 = TierMintPriceKey{tier: arg1};
        if (0x2::dynamic_field::exists<TierMintPriceKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<TierMintPriceKey, TierMintPrice>(&arg0.id, v0).public_mint_price
        } else {
            arg0.public_mint_price
        }
    }

    fun update_mask(arg0: u128, arg1: u8, arg2: bool) : u128 {
        if (arg2) {
            arg0 | 1 << arg1
        } else {
            arg0 & (340282366920938463463374607431768211455 ^ 1 << arg1)
        }
    }

    fun write_package_control(arg0: &mut AdminCap, arg1: &mut MintSettings, arg2: u64, arg3: u128) {
        let v0 = &mut arg0.id;
        write_package_control_id(v0, arg2, arg3);
        let v1 = &mut arg1.id;
        write_package_control_id(v1, arg2, arg3);
    }

    fun write_package_control_id(arg0: &mut 0x2::object::UID, arg1: u64, arg2: u128) {
        let v0 = PackageControlKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<PackageControlKey, PackageControl>(arg0, v0);
        v1.version = arg1;
        v1.function_mask = arg2;
    }

    public fun z_points_amount(arg0: &ZPoints) : u64 {
        arg0.amount
    }

    public fun z_points_balance(arg0: &SudoCard) : u64 {
        let v0 = ZPointsBalanceKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ZPointsBalanceKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = ZPointsBalanceKey{dummy_field: false};
        *0x2::dynamic_field::borrow<ZPointsBalanceKey, u64>(&arg0.id, v1)
    }

    fun z_points_balance_mut(arg0: &mut SudoCard) : &mut u64 {
        let v0 = ZPointsBalanceKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ZPointsBalanceKey>(&arg0.id, v0)) {
            let v1 = ZPointsBalanceKey{dummy_field: false};
            0x2::dynamic_field::add<ZPointsBalanceKey, u64>(&mut arg0.id, v1, 0);
        };
        let v2 = ZPointsBalanceKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ZPointsBalanceKey, u64>(&mut arg0.id, v2)
    }

    // decompiled from Move bytecode v7
}

