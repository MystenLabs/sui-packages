module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels {
    struct Shovel has store, key {
        id: 0x2::object::UID,
        serial: u64,
        ruleset: u64,
        class: u8,
        durability: u64,
        max_durability: u64,
        repairs: u64,
        season: u64,
        dug: u64,
    }

    struct Ruleset has copy, drop, store {
        class: u8,
        life: vector<u64>,
        reach: u64,
        wear: u64,
        made: u64,
    }

    struct ShedCap has store, key {
        id: 0x2::object::UID,
        shed: 0x2::object::ID,
    }

    struct Shed has key {
        id: 0x2::object::UID,
        version: u64,
        mint_open: bool,
        cap: u64,
        minted: u64,
        burned: u64,
        reserved: u64,
        price: u64,
        payee: address,
        sealed_ok: bool,
        ruleset: u64,
        rulesets: 0x2::table::Table<u64, Ruleset>,
        first_by_wallet: 0x2::table::Table<address, 0x2::object::ID>,
        first_by_grave: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct ShedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PolicyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ShedCreated has copy, drop {
        shed: 0x2::object::ID,
        policy: 0x2::object::ID,
        admin_to: address,
    }

    struct ShedConfigured has copy, drop {
        shed: 0x2::object::ID,
        mint_open: bool,
        cap: u64,
        price: u64,
        payee: address,
        sealed_ok: bool,
        ruleset: u64,
    }

    struct RulesetSet has copy, drop {
        shed: 0x2::object::ID,
        id: u64,
        class: u8,
        life: vector<u64>,
        reach: u64,
        wear: u64,
    }

    struct ShovelMade has copy, drop {
        shovel: 0x2::object::ID,
        serial: u64,
        ruleset: u64,
        class: u8,
        durability: u64,
        by: address,
        grave: 0x2::object::ID,
        paid: u64,
    }

    struct ShovelBurned has copy, drop {
        shovel: 0x2::object::ID,
        serial: u64,
        dug: u64,
        by: address,
    }

    entry fun add_ruleset(arg0: &ShedCap, arg1: &mut Shed, arg2: u8, arg3: vector<u64>, arg4: u64, arg5: u64) {
        check_admin(arg0, arg1);
        check_ruleset(&arg3, arg4, arg5);
        let v0 = 0x2::table::length<u64, Ruleset>(&arg1.rulesets) + 1;
        let v1 = Ruleset{
            class : arg2,
            life  : arg3,
            reach : arg4,
            wear  : arg5,
            made  : 0,
        };
        0x2::table::add<u64, Ruleset>(&mut arg1.rulesets, v0, v1);
        ruleset_set(arg1, v0);
    }

    public fun burned(arg0: &Shed) : u64 {
        arg0.burned
    }

    public fun cap(arg0: &Shed) : u64 {
        arg0.cap
    }

    fun check_admin(arg0: &ShedCap, arg1: &Shed) {
        assert!(arg0.shed == 0x2::object::id<Shed>(arg1), 431);
        check_version(arg1);
    }

    fun check_ruleset(arg0: &vector<u64>, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 >= 1 && v0 <= 8, 445);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(arg0, v1);
            assert!(v2 >= 1 && v2 <= 1000, 445);
            if (v1 > 0) {
                assert!(v2 <= *0x1::vector::borrow<u64>(arg0, v1 - 1), 445);
            };
            v1 = v1 + 1;
        };
        assert!(arg1 >= 1 && arg1 <= 10000, 445);
        assert!(arg2 >= 1 && arg2 <= *0x1::vector::borrow<u64>(arg0, 0), 445);
    }

    fun check_version(arg0: &Shed) {
        assert!(arg0.version == 1, 430);
    }

    entry fun claim_first(arg0: &mut Shed, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        first(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun claim_first_personal(arg0: &mut Shed, arg1: &0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        first(arg0, arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg3, arg4, arg5);
    }

    public fun class(arg0: &Shovel) : u8 {
        arg0.class
    }

    fun configured(arg0: &Shed) {
        let v0 = ShedConfigured{
            shed      : 0x2::object::id<Shed>(arg0),
            mint_open : arg0.mint_open,
            cap       : arg0.cap,
            price     : arg0.price,
            payee     : arg0.payee,
            sealed_ok : arg0.sealed_ok,
            ruleset   : arg0.ruleset,
        };
        0x2::event::emit<ShedConfigured>(v0);
    }

    public fun current_ruleset(arg0: &Shed) : u64 {
        arg0.ruleset
    }

    public(friend) fun destroy(arg0: &mut Shed, arg1: Shovel, arg2: &0x2::tx_context::TxContext) {
        let Shovel {
            id             : v0,
            serial         : v1,
            ruleset        : _,
            class          : _,
            durability     : _,
            max_durability : _,
            repairs        : _,
            season         : _,
            dug            : v8,
        } = arg1;
        let v9 = v0;
        let v10 = ShovelBurned{
            shovel : 0x2::object::uid_to_inner(&v9),
            serial : v1,
            dug    : v8,
            by     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ShovelBurned>(v10);
        0x2::object::delete(v9);
        arg0.burned = arg0.burned + 1;
    }

    public fun dug(arg0: &Shovel) : u64 {
        arg0.dug
    }

    public fun durability(arg0: &Shovel) : u64 {
        arg0.durability
    }

    entry fun edit_ruleset(arg0: &ShedCap, arg1: &mut Shed, arg2: u64, arg3: u8, arg4: vector<u64>, arg5: u64, arg6: u64) {
        check_admin(arg0, arg1);
        assert!(0x2::table::contains<u64, Ruleset>(&arg1.rulesets, arg2), 447);
        check_ruleset(&arg4, arg5, arg6);
        let v0 = 0x2::table::borrow_mut<u64, Ruleset>(&mut arg1.rulesets, arg2);
        assert!(v0.made == 0, 446);
        v0.class = arg3;
        v0.life = arg4;
        v0.reach = arg5;
        v0.wear = arg6;
        ruleset_set(arg1, arg2);
    }

    public fun existing(arg0: &Shed) : u64 {
        arg0.minted - arg0.burned
    }

    fun fields() : vector<0x1::string::String> {
        let v0 = 0x1::string::utf8(b"https://mortem.alienz.tech/assets/shovels/v1/");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"{class}.webp"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Shovel #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"A gravedigger's shovel for the MORTEM graves. It wears down as it digs, takes a few repairs, and in the end it breaks for good."));
        0x1::vector::push_back<0x1::string::String>(v2, v0);
        0x1::vector::push_back<0x1::string::String>(v2, v0);
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"https://mortem.alienz.tech/"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"PulseSinister & Sudcero"));
        v1
    }

    fun first(arg0: &mut Shed, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.mint_open, 435);
        prove(arg1, arg2, arg3, arg0.sealed_ok);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.first_by_wallet, v0), 439);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.first_by_grave, arg3), 440);
        assert!(existing(arg0) + arg0.reserved < arg0.cap, 441);
        let v1 = arg0.price;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v1, 442);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1, arg5), arg0.payee);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1, arg5));
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        let v2 = make(arg0, arg5);
        let v3 = 0x2::object::id<Shovel>(&v2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.first_by_wallet, v0, v3);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.first_by_grave, arg3, v3);
        let v4 = ShovelMade{
            shovel     : v3,
            serial     : v2.serial,
            ruleset    : v2.ruleset,
            class      : v2.class,
            durability : v2.durability,
            by         : v0,
            grave      : arg3,
            paid       : v1,
        };
        0x2::event::emit<ShovelMade>(v4);
        0x2::transfer::public_transfer<Shovel>(v2, v0);
    }

    public fun grave_has_first(arg0: &Shed, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.first_by_grave, arg1)
    }

    public fun has_first(arg0: &Shed, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.first_by_wallet, arg1)
    }

    fun keys() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        v0
    }

    fun make(arg0: &mut Shed, arg1: &mut 0x2::tx_context::TxContext) : Shovel {
        arg0.minted = arg0.minted + 1;
        let v0 = arg0.ruleset;
        let v1 = 0x2::table::borrow_mut<u64, Ruleset>(&mut arg0.rulesets, v0);
        v1.made = v1.made + 1;
        let v2 = *0x1::vector::borrow<u64>(&v1.life, 0);
        Shovel{
            id             : 0x2::object::new(arg1),
            serial         : arg0.minted,
            ruleset        : v0,
            class          : v1.class,
            durability     : v2,
            max_durability : v2,
            repairs        : 0,
            season         : 0,
            dug            : 0,
        }
    }

    public fun max_durability(arg0: &Shovel) : u64 {
        arg0.max_durability
    }

    public fun mint_open(arg0: &Shed) : bool {
        arg0.mint_open
    }

    public fun minted(arg0: &Shed) : u64 {
        arg0.minted
    }

    public fun price(arg0: &Shed) : u64 {
        arg0.price
    }

    fun prove(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: bool) {
        assert!(0x2::kiosk::has_item_with_type<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg0, arg2), 436);
        assert!(!0x2::kiosk::is_listed(arg0, arg2), 437);
        let v0 = 0x2::kiosk::borrow<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg0, arg1, arg2);
        assert!(arg3 || 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::is_risen(v0), 438);
    }

    public fun repairs(arg0: &Shovel) : u64 {
        arg0.repairs
    }

    public fun reserved(arg0: &Shed) : u64 {
        arg0.reserved
    }

    public fun ruleset(arg0: &Shed, arg1: u64) : (u8, vector<u64>, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u64, Ruleset>(&arg0.rulesets, arg1);
        (v0.class, v0.life, v0.reach, v0.wear, v0.made)
    }

    public fun ruleset_of(arg0: &Shovel) : u64 {
        arg0.ruleset
    }

    fun ruleset_set(arg0: &Shed, arg1: u64) {
        let v0 = 0x2::table::borrow<u64, Ruleset>(&arg0.rulesets, arg1);
        let v1 = RulesetSet{
            shed  : 0x2::object::id<Shed>(arg0),
            id    : arg1,
            class : v0.class,
            life  : v0.life,
            reach : v0.reach,
            wear  : v0.wear,
        };
        0x2::event::emit<RulesetSet>(v1);
    }

    public fun season(arg0: &Shovel) : u64 {
        arg0.season
    }

    public fun serial(arg0: &Shovel) : u64 {
        arg0.serial
    }

    entry fun set_cap(arg0: &ShedCap, arg1: &mut Shed, arg2: u64) {
        check_admin(arg0, arg1);
        assert!(arg2 >= existing(arg1) + arg1.reserved && arg2 <= 666, 443);
        arg1.cap = arg2;
        configured(arg1);
    }

    entry fun set_mint_open(arg0: &ShedCap, arg1: &mut Shed, arg2: bool) {
        check_admin(arg0, arg1);
        arg1.mint_open = arg2;
        configured(arg1);
    }

    entry fun set_payee(arg0: &ShedCap, arg1: &mut Shed, arg2: address) {
        check_admin(arg0, arg1);
        arg1.payee = arg2;
        configured(arg1);
    }

    entry fun set_price(arg0: &ShedCap, arg1: &mut Shed, arg2: u64) {
        check_admin(arg0, arg1);
        assert!(arg2 <= 1000000000, 444);
        arg1.price = arg2;
        configured(arg1);
    }

    entry fun set_sealed_ok(arg0: &ShedCap, arg1: &mut Shed, arg2: bool) {
        check_admin(arg0, arg1);
        arg1.sealed_ok = arg2;
        configured(arg1);
    }

    entry fun setup(arg0: &0x2::package::Publisher, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::well::Well, arg2: &mut 0x2::display_registry::DisplayRegistry, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Shovel>(arg0), 432);
        let v0 = 0x2::object::id<0x2::display_registry::DisplayRegistry>(arg2);
        assert!(0x2::object::id_to_address(&v0) == @0xd, 433);
        let v1 = ShedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<ShedKey>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::well::uid(arg1), v1), 434);
        let v2 = Shed{
            id              : 0x2::object::new(arg5),
            version         : 1,
            mint_open       : false,
            cap             : 133,
            minted          : 0,
            burned          : 0,
            reserved        : 0,
            price           : 100000000,
            payee           : arg4,
            sealed_ok       : false,
            ruleset         : 1,
            rulesets        : 0x2::table::new<u64, Ruleset>(arg5),
            first_by_wallet : 0x2::table::new<address, 0x2::object::ID>(arg5),
            first_by_grave  : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg5),
        };
        let v3 = Ruleset{
            class : 0,
            life  : vector[24, 18, 12],
            reach : 500,
            wear  : 1,
            made  : 0,
        };
        0x2::table::add<u64, Ruleset>(&mut v2.rulesets, 1, v3);
        let v4 = 0x2::object::id<Shed>(&v2);
        let v5 = ShedKey{dummy_field: false};
        0x2::dynamic_field::add<ShedKey, 0x2::object::ID>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::well::uid_mut(arg1), v5, v4);
        let (v6, v7) = 0x2::transfer_policy::new<Shovel>(arg0, arg5);
        let v8 = v6;
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Shovel>>(v8);
        let v9 = PolicyCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<PolicyCapKey, 0x2::transfer_policy::TransferPolicyCap<Shovel>>(&mut v2.id, v9, v7);
        let v10 = 0x2::display::new_with_fields<Shovel>(arg0, keys(), fields(), arg5);
        0x2::display::update_version<Shovel>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<Shovel>>(v10, arg3);
        let (v11, v12) = 0x2::display_registry::new<Shovel>(arg2, 0x1::internal::permit<Shovel>(), arg5);
        let v13 = v12;
        let v14 = v11;
        let v15 = fields();
        let v16 = keys();
        let v17 = 0;
        while (v17 < 0x1::vector::length<0x1::string::String>(&v16)) {
            0x2::display_registry::set<Shovel>(&mut v14, &v13, *0x1::vector::borrow<0x1::string::String>(&v16, v17), *0x1::vector::borrow<0x1::string::String>(&v15, v17));
            v17 = v17 + 1;
        };
        0x2::display_registry::share<Shovel>(v14);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Shovel>>(v13, arg3);
        let v18 = ShedCap{
            id   : 0x2::object::new(arg5),
            shed : v4,
        };
        0x2::transfer::public_transfer<ShedCap>(v18, arg3);
        let v19 = ShedCreated{
            shed     : v4,
            policy   : 0x2::object::id<0x2::transfer_policy::TransferPolicy<Shovel>>(&v8),
            admin_to : arg3,
        };
        0x2::event::emit<ShedCreated>(v19);
        ruleset_set(&v2, 1);
        configured(&v2);
        0x2::transfer::share_object<Shed>(v2);
    }

    public fun shed_id(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::well::Well) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::well::uid(arg0);
        let v1 = ShedKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ShedKey>(v0, v1)) {
            let v3 = ShedKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<ShedKey, 0x2::object::ID>(v0, v3))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    entry fun transfer_admin(arg0: ShedCap, arg1: address) {
        0x2::transfer::public_transfer<ShedCap>(arg0, arg1);
    }

    entry fun use_ruleset(arg0: &ShedCap, arg1: &mut Shed, arg2: u64) {
        check_admin(arg0, arg1);
        assert!(0x2::table::contains<u64, Ruleset>(&arg1.rulesets, arg2), 447);
        arg1.ruleset = arg2;
        configured(arg1);
    }

    // decompiled from Move bytecode v7
}

