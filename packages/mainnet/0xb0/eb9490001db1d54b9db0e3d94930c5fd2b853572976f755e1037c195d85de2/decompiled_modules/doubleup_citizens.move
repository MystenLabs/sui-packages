module 0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::doubleup_citizens {
    struct DoubleUpCitizen has store, key {
        id: 0x2::object::UID,
        number: u64,
        attributes: 0x1::option::Option<Attributes>,
        rarity: 0x1::string::String,
        is_revealed: bool,
        img_url: 0x1::string::String,
    }

    struct RevealTicket has store, key {
        id: 0x2::object::UID,
        number: u64,
        attributes: Attributes,
        rarity: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct DOUBLEUP_CITIZENS has drop {
        dummy_field: bool,
    }

    struct WhitelistTicket has key {
        id: 0x2::object::UID,
    }

    struct FeesCollector has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        current_population: u64,
        collection_size: u64,
        public_price: u64,
        whitelist_price: u64,
        open_to_public: bool,
        can_mint: bool,
    }

    struct Attributes has store {
        overlays: 0x1::string::String,
        headwear: 0x1::string::String,
        earrings: 0x1::string::String,
        hairstyle: 0x1::string::String,
        facewear: 0x1::string::String,
        chestwear: 0x1::string::String,
        eyes: 0x1::string::String,
        pupils: 0x1::string::String,
        iris: 0x1::string::String,
        makeup: 0x1::string::String,
        mouth: 0x1::string::String,
        outerwear: 0x1::string::String,
        innerwear: 0x1::string::String,
        neckwear: 0x1::string::String,
        base: 0x1::string::String,
        bgs: 0x1::string::String,
    }

    struct ObjectReceivedEvent has copy, drop {
        citizen_id: 0x2::object::ID,
        received_object_id: 0x2::object::ID,
        received_object_type: 0x1::type_name::TypeName,
    }

    struct MintEvent has copy, drop {
        citizen_id: 0x2::object::ID,
        citizen_number: u64,
        minted_by: address,
    }

    struct RevealEvent has copy, drop {
        citizen_id: 0x2::object::ID,
        citizen_number: u64,
        rarity: 0x1::string::String,
        revealed_by: address,
    }

    public fun id(arg0: &DoubleUpCitizen) : 0x2::object::ID {
        0x2::object::id<DoubleUpCitizen>(arg0)
    }

    public fun admin_edit_can_mint(arg0: &mut FeesCollector, arg1: bool, arg2: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap) {
        arg0.can_mint = arg1;
    }

    public fun admin_edit_collection_size(arg0: &mut FeesCollector, arg1: u64, arg2: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap) {
        assert!(arg1 > arg0.collection_size, 4);
        arg0.collection_size = arg1;
    }

    public fun admin_edit_open_to_public(arg0: &mut FeesCollector, arg1: bool, arg2: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap) {
        arg0.open_to_public = arg1;
    }

    public fun admin_edit_public_price(arg0: &mut FeesCollector, arg1: u64, arg2: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap) {
        arg0.public_price = arg1;
    }

    public fun admin_edit_whitelist_price(arg0: &mut FeesCollector, arg1: u64, arg2: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap) {
        arg0.whitelist_price = arg1;
    }

    public fun admin_issue_whitelist_ticket(arg0: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = WhitelistTicket{id: 0x2::object::new(arg2)};
            0x2::transfer::transfer<WhitelistTicket>(v0, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    public fun admin_mint(arg0: &mut FeesCollector, arg1: u64, arg2: Attributes, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap, arg6: &mut 0x2::tx_context::TxContext) : DoubleUpCitizen {
        arg0.collection_size = arg0.collection_size + 1;
        DoubleUpCitizen{
            id          : 0x2::object::new(arg6),
            number      : arg1,
            attributes  : 0x1::option::some<Attributes>(arg2),
            rarity      : arg3,
            is_revealed : true,
            img_url     : arg4,
        }
    }

    public fun admin_mint_reveal_ticket(arg0: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap, arg1: u64, arg2: Attributes, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : RevealTicket {
        RevealTicket{
            id         : 0x2::object::new(arg5),
            number     : arg1,
            attributes : arg2,
            rarity     : arg3,
            img_url    : arg4,
        }
    }

    public fun admin_new_attributes(arg0: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String) : Attributes {
        Attributes{
            overlays  : arg1,
            headwear  : arg2,
            earrings  : arg3,
            hairstyle : arg4,
            facewear  : arg5,
            chestwear : arg6,
            eyes      : arg7,
            pupils    : arg8,
            iris      : arg9,
            makeup    : arg10,
            mouth     : arg11,
            outerwear : arg12,
            innerwear : arg13,
            neckwear  : arg14,
            base      : arg15,
            bgs       : arg16,
        }
    }

    public fun admin_withdraw_fees(arg0: &mut FeesCollector, arg1: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun attributes(arg0: &DoubleUpCitizen) : &Attributes {
        0x1::option::borrow<Attributes>(&arg0.attributes)
    }

    public fun citizenCount(arg0: &FeesCollector) : u64 {
        arg0.current_population
    }

    public fun destroy_reveal_ticket(arg0: RevealTicket) : Attributes {
        let RevealTicket {
            id         : v0,
            number     : _,
            attributes : v2,
            rarity     : _,
            img_url    : _,
        } = arg0;
        0x2::object::delete(v0);
        v2
    }

    public fun destroy_whitelist_ticket(arg0: WhitelistTicket) {
        let WhitelistTicket { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun imgUrl(arg0: &DoubleUpCitizen) : &0x1::string::String {
        &arg0.img_url
    }

    fun init(arg0: DOUBLEUP_CITIZENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DOUBLEUP_CITIZENS>(arg0, arg1);
        let v1 = FeesCollector{
            id                 : 0x2::object::new(arg1),
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            current_population : 0,
            collection_size    : 0,
            public_price       : 55000000000,
            whitelist_price    : 35000000000,
            open_to_public     : false,
            can_mint           : false,
        };
        let v2 = 0x2::display::new<DoubleUpCitizen>(&v0, arg1);
        0x2::display::add<DoubleUpCitizen>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"DoubleUp Citizen #{number}"));
        0x2::display::add<DoubleUpCitizen>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{img_url}"));
        0x2::display::add<DoubleUpCitizen>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A citizen on the DoubleUp Island!"));
        0x2::display::add<DoubleUpCitizen>(&mut v2, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<DoubleUpCitizen>(&mut v2, 0x1::string::utf8(b"class"), 0x1::string::utf8(b"{class}"));
        0x2::display::update_version<DoubleUpCitizen>(&mut v2);
        let v3 = 0x2::display::new<WhitelistTicket>(&v0, arg1);
        0x2::display::add<WhitelistTicket>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"DoubleUp Whitelist Ticket"));
        0x2::display::add<WhitelistTicket>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Mint your DoubleUp Citizen with this ticket at a legendary price"));
        0x2::display::add<WhitelistTicket>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"TODO: add image url"));
        0x2::display::update_version<WhitelistTicket>(&mut v3);
        let v4 = 0x2::display::new<RevealTicket>(&v0, arg1);
        0x2::display::add<RevealTicket>(&mut v4, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"DoubleUp Reveal Ticket"));
        0x2::display::add<RevealTicket>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Let the curtains fall. Which citizen are you?"));
        0x2::display::add<RevealTicket>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"TODO: add image url"));
        0x2::display::update_version<RevealTicket>(&mut v4);
        let (v5, v6) = 0x2::transfer_policy::new<DoubleUpCitizen>(&v0, arg1);
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<DoubleUpCitizen>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<DoubleUpCitizen>>(v6, v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v7);
        0x2::transfer::public_transfer<0x2::display::Display<DoubleUpCitizen>>(v2, v7);
        0x2::transfer::public_transfer<0x2::display::Display<WhitelistTicket>>(v3, v7);
        0x2::transfer::public_transfer<0x2::display::Display<RevealTicket>>(v4, v7);
        0x2::transfer::share_object<FeesCollector>(v1);
    }

    public fun maxCount(arg0: &FeesCollector) : u64 {
        arg0.collection_size
    }

    public fun mint(arg0: &mut FeesCollector, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::option::Option<WhitelistTicket>, arg3: &mut 0x2::tx_context::TxContext) : DoubleUpCitizen {
        assert!(arg0.can_mint, 7);
        assert!(arg0.current_population < arg0.collection_size, 1);
        if (0x1::option::is_some<WhitelistTicket>(&arg2)) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.whitelist_price, 0);
            destroy_whitelist_ticket(0x1::option::destroy_some<WhitelistTicket>(arg2));
        } else {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.public_price, 0);
            assert!(arg0.open_to_public, 5);
            0x1::option::destroy_none<WhitelistTicket>(arg2);
        };
        arg0.current_population = arg0.current_population + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = DoubleUpCitizen{
            id          : 0x2::object::new(arg3),
            number      : arg0.current_population,
            attributes  : 0x1::option::none<Attributes>(),
            rarity      : 0x1::string::utf8(b"Unknown"),
            is_revealed : false,
            img_url     : 0x1::string::utf8(b"https://d1fvsuv3rrz9o2.cloudfront.net/unrevealed.gif"),
        };
        let v1 = MintEvent{
            citizen_id     : 0x2::object::id<DoubleUpCitizen>(&v0),
            citizen_number : v0.number,
            minted_by      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintEvent>(v1);
        v0
    }

    public fun number(arg0: &DoubleUpCitizen) : u64 {
        arg0.number
    }

    public fun publicPrice(arg0: &FeesCollector) : u64 {
        arg0.public_price
    }

    public fun rarity(arg0: &DoubleUpCitizen) : &0x1::string::String {
        &arg0.rarity
    }

    public(friend) fun receive<T0: store + key>(arg0: &mut DoubleUpCitizen, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        let v0 = 0x2::transfer::public_receive<T0>(&mut arg0.id, arg1);
        let v1 = ObjectReceivedEvent{
            citizen_id           : id(arg0),
            received_object_id   : 0x2::object::id<T0>(&v0),
            received_object_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObjectReceivedEvent>(v1);
        v0
    }

    public fun reveal(arg0: DoubleUpCitizen, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<DoubleUpCitizen>, arg4: 0x2::transfer::Receiving<RevealTicket>, arg5: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        let v1 = receive<RevealTicket>(v0, arg4);
        assert!(v1.number == arg0.number, 6);
        assert!(arg0.is_revealed == false, 2);
        arg0.rarity = v1.rarity;
        arg0.img_url = v1.img_url;
        arg0.is_revealed = true;
        0x1::option::fill<Attributes>(&mut arg0.attributes, destroy_reveal_ticket(v1));
        let v2 = RevealEvent{
            citizen_id     : 0x2::object::id<DoubleUpCitizen>(&arg0),
            citizen_number : arg0.number,
            rarity         : arg0.rarity,
            revealed_by    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RevealEvent>(v2);
        0x2::kiosk::lock<DoubleUpCitizen>(arg1, arg2, arg3, arg0);
    }

    public fun whitelistPrice(arg0: &FeesCollector) : u64 {
        arg0.whitelist_price
    }

    // decompiled from Move bytecode v6
}

