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

    struct ReservationsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Reservations has store {
        ms: u64,
        queue: 0x2::table::Table<u64, Reservation>,
        head: u64,
        tail: u64,
        held: 0x2::table::Table<address, vector<u64>>,
    }

    struct Reservation has drop, store {
        wallet: address,
        until: u64,
        live: bool,
    }

    struct FusedKey has copy, drop, store {
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

    struct Reserved has copy, drop {
        wallet: address,
        until: u64,
        reserved: u64,
    }

    struct ReservationUsed has copy, drop {
        wallet: address,
        reserved: u64,
    }

    struct ReservationEnded has copy, drop {
        wallet: address,
        until: u64,
    }

    struct Repaired has copy, drop {
        shovel: 0x2::object::ID,
        repairs: u64,
        durability: u64,
    }

    struct Fused has copy, drop {
        shovel: 0x2::object::ID,
        donor: 0x2::object::ID,
        durability: u64,
        repairs: u64,
        dug: u64,
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

    public(friend) fun cap_shed(arg0: &ShedCap) : 0x2::object::ID {
        arg0.shed
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
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(arg0)) {
            let v4 = 0x1::vector::borrow<u64>(arg0, v3);
            assert!(*v4 >= arg2 && *v4 % arg2 == 0, 445);
            v3 = v3 + 1;
        };
    }

    fun check_version(arg0: &Shed) {
        assert!(arg0.version == 2, 430);
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
        let v10 = FusedKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FusedKey>(&v9, v10)) {
            let v11 = FusedKey{dummy_field: false};
            0x2::dynamic_field::remove<FusedKey, vector<0x2::object::ID>>(&mut v9, v11);
        };
        let v12 = ShovelBurned{
            shovel : 0x2::object::uid_to_inner(&v9),
            serial : v1,
            dug    : v8,
            by     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ShovelBurned>(v12);
        0x2::object::delete(v9);
        arg0.burned = arg0.burned + 1;
    }

    public(friend) fun dig_terms(arg0: &Shed, arg1: &Shovel) : (u64, u64) {
        let v0 = 0x2::table::borrow<u64, Ruleset>(&arg0.rulesets, arg1.ruleset);
        (v0.reach, v0.wear)
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

    public(friend) fun expire(arg0: &mut Shed, arg1: u64, arg2: u64) {
        let v0 = ReservationsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ReservationsKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0;
        let v2 = 0;
        let v3 = ReservationsKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<ReservationsKey, Reservations>(&mut arg0.id, v3);
        while (v4.head < v4.tail && v2 < arg2) {
            let v5 = 0x2::table::borrow<u64, Reservation>(&v4.queue, v4.head);
            if (v5.live && v5.until > arg1) {
                break
            };
            let Reservation {
                wallet : v6,
                until  : v7,
                live   : v8,
            } = 0x2::table::remove<u64, Reservation>(&mut v4.queue, v4.head);
            if (v8) {
                v1 = v1 + 1;
                let v9 = ReservationEnded{
                    wallet : v6,
                    until  : v7,
                };
                0x2::event::emit<ReservationEnded>(v9);
            };
            v4.head = v4.head + 1;
            v2 = v2 + 1;
        };
        arg0.reserved = arg0.reserved - v1;
    }

    entry fun expire_reservations(arg0: &mut Shed, arg1: &0x2::clock::Clock) {
        check_version(arg0);
        expire(arg0, 0x2::clock::timestamp_ms(arg1), 20);
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

    public(friend) fun fuse(arg0: &mut Shed, arg1: &mut Shovel, arg2: Shovel, arg3: address, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.class == arg2.class, 450);
        assert!(arg1.ruleset == arg2.ruleset, 453);
        assert!(arg1.durability > 0 && arg2.durability > 0, 451);
        let v0 = 0x2::table::borrow<u64, Ruleset>(&arg0.rulesets, arg1.ruleset).life;
        let v1 = if (arg1.repairs > arg2.repairs) {
            arg1.repairs
        } else {
            arg2.repairs
        };
        let v2 = v1;
        if (v1 >= 0x1::vector::length<u64>(&v0)) {
            v2 = 0x1::vector::length<u64>(&v0) - 1;
        };
        let v3 = *0x1::vector::borrow<u64>(&v0, v2);
        let v4 = arg1.durability + arg2.durability;
        arg1.repairs = v2;
        arg1.max_durability = v3;
        let v5 = if (v4 < v3) {
            v4
        } else {
            v3
        };
        arg1.durability = v5;
        arg1.dug = arg1.dug + arg2.dug;
        let v6 = 0x2::object::id<Shovel>(&arg2);
        let v7 = FusedKey{dummy_field: false};
        let v8 = if (0x2::dynamic_field::exists<FusedKey>(&arg2.id, v7)) {
            let v9 = FusedKey{dummy_field: false};
            0x2::dynamic_field::remove<FusedKey, vector<0x2::object::ID>>(&mut arg2.id, v9)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        };
        let v10 = FusedKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FusedKey>(&arg1.id, v10)) {
            let v11 = FusedKey{dummy_field: false};
            0x2::dynamic_field::add<FusedKey, vector<0x2::object::ID>>(&mut arg1.id, v11, 0x1::vector::empty<0x2::object::ID>());
        };
        let v12 = FusedKey{dummy_field: false};
        let v13 = 0x2::dynamic_field::borrow_mut<FusedKey, vector<0x2::object::ID>>(&mut arg1.id, v12);
        0x1::vector::append<0x2::object::ID>(v13, v8);
        0x1::vector::push_back<0x2::object::ID>(v13, v6);
        let v14 = Fused{
            shovel     : 0x2::object::id<Shovel>(arg1),
            donor      : v6,
            durability : arg1.durability,
            repairs    : v2,
            dug        : arg1.dug,
        };
        0x2::event::emit<Fused>(v14);
        destroy(arg0, arg2, arg5);
        reserve(arg0, arg3, arg4);
    }

    public fun fused_from(arg0: &Shovel) : vector<0x2::object::ID> {
        let v0 = FusedKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FusedKey>(&arg0.id, v0)) {
            let v2 = FusedKey{dummy_field: false};
            *0x2::dynamic_field::borrow<FusedKey, vector<0x2::object::ID>>(&arg0.id, v2)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
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

    public(friend) fun life_of(arg0: &Shed, arg1: &Shovel) : vector<u64> {
        0x2::table::borrow<u64, Ruleset>(&arg0.rulesets, arg1.ruleset).life
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

    entry fun migrate(arg0: &ShedCap, arg1: &mut Shed) {
        assert!(arg0.shed == 0x2::object::id<Shed>(arg1), 431);
        assert!(arg1.version < 2, 430);
        arg1.version = 2;
    }

    public fun mint_open(arg0: &Shed) : bool {
        arg0.mint_open
    }

    public fun minted(arg0: &Shed) : u64 {
        arg0.minted
    }

    public(friend) fun open_reservations(arg0: &mut Shed, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ReservationsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ReservationsKey>(&arg0.id, v0)) {
            return
        };
        let v1 = ReservationsKey{dummy_field: false};
        let v2 = Reservations{
            ms    : arg1,
            queue : 0x2::table::new<u64, Reservation>(arg2),
            head  : 0,
            tail  : 0,
            held  : 0x2::table::new<address, vector<u64>>(arg2),
        };
        0x2::dynamic_field::add<ReservationsKey, Reservations>(&mut arg0.id, v1, v2);
    }

    public fun price(arg0: &Shed) : u64 {
        arg0.price
    }

    public(friend) fun prove(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: bool) {
        assert!(0x2::kiosk::has_item_with_type<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg0, arg2), 436);
        assert!(!0x2::kiosk::is_listed(arg0, arg2), 437);
        let v0 = 0x2::kiosk::borrow<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg0, arg1, arg2);
        assert!(arg3 || 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::is_risen(v0), 438);
    }

    public(friend) fun repair(arg0: &Shed, arg1: &mut Shovel) {
        assert!(arg1.durability < 0x2::table::borrow<u64, Ruleset>(&arg0.rulesets, arg1.ruleset).wear, 448);
        let v0 = 0x2::table::borrow<u64, Ruleset>(&arg0.rulesets, arg1.ruleset).life;
        assert!(arg1.repairs + 1 < 0x1::vector::length<u64>(&v0), 449);
        arg1.repairs = arg1.repairs + 1;
        arg1.max_durability = *0x1::vector::borrow<u64>(&v0, arg1.repairs);
        arg1.durability = arg1.max_durability;
        let v1 = Repaired{
            shovel     : 0x2::object::id<Shovel>(arg1),
            repairs    : arg1.repairs,
            durability : arg1.durability,
        };
        0x2::event::emit<Repaired>(v1);
    }

    public fun repairs(arg0: &Shovel) : u64 {
        arg0.repairs
    }

    public(friend) fun replacement(arg0: &mut Shed, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Shovel {
        let v0 = take_reservation(arg0, arg1, arg2);
        if (!v0) {
            expire(arg0, arg2, 8);
            assert!(existing(arg0) + arg0.reserved < arg0.cap, 441);
        };
        let v1 = make(arg0, arg4);
        let v2 = ShovelMade{
            shovel     : 0x2::object::id<Shovel>(&v1),
            serial     : v1.serial,
            ruleset    : v1.ruleset,
            class      : v1.class,
            durability : v1.durability,
            by         : arg1,
            grave      : 0x2::object::id_from_address(@0x0),
            paid       : arg3,
        };
        0x2::event::emit<ShovelMade>(v2);
        v1
    }

    public(friend) fun reservations_open(arg0: &Shed) : bool {
        let v0 = ReservationsKey{dummy_field: false};
        0x2::dynamic_field::exists<ReservationsKey>(&arg0.id, v0)
    }

    public(friend) fun reserve(arg0: &mut Shed, arg1: address, arg2: u64) {
        let v0 = ReservationsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ReservationsKey>(&arg0.id, v0), 452);
        arg0.reserved = arg0.reserved + 1;
        let v1 = ReservationsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<ReservationsKey, Reservations>(&mut arg0.id, v1);
        let v3 = arg2 + v2.ms;
        let v4 = v2.tail;
        let v5 = Reservation{
            wallet : arg1,
            until  : v3,
            live   : true,
        };
        0x2::table::add<u64, Reservation>(&mut v2.queue, v4, v5);
        v2.tail = v4 + 1;
        if (!0x2::table::contains<address, vector<u64>>(&v2.held, arg1)) {
            0x2::table::add<address, vector<u64>>(&mut v2.held, arg1, vector[]);
        };
        0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut v2.held, arg1), v4);
        let v6 = Reserved{
            wallet   : arg1,
            until    : v3,
            reserved : arg0.reserved,
        };
        0x2::event::emit<Reserved>(v6);
    }

    public fun reserved(arg0: &Shed) : u64 {
        arg0.reserved
    }

    public fun reserved_for(arg0: &Shed, arg1: address, arg2: u64) : u64 {
        let v0 = ReservationsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ReservationsKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = ReservationsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<ReservationsKey, Reservations>(&arg0.id, v1);
        if (!0x2::table::contains<address, vector<u64>>(&v2.held, arg1)) {
            return 0
        };
        let v3 = 0x2::table::borrow<address, vector<u64>>(&v2.held, arg1);
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(v3)) {
            let v6 = *0x1::vector::borrow<u64>(v3, v5);
            if (0x2::table::contains<u64, Reservation>(&v2.queue, v6)) {
                let v7 = 0x2::table::borrow<u64, Reservation>(&v2.queue, v6);
                if (v7.live && v7.until > arg2) {
                    v4 = v4 + 1;
                };
            };
            v5 = v5 + 1;
        };
        v4
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

    public(friend) fun set_reservation_ms(arg0: &mut Shed, arg1: u64) {
        let v0 = ReservationsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ReservationsKey, Reservations>(&mut arg0.id, v0).ms = arg1;
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
            version         : 2,
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

    public(friend) fun shed_uid(arg0: &Shed) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun shed_uid_mut(arg0: &mut Shed) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun take_reservation(arg0: &mut Shed, arg1: address, arg2: u64) : bool {
        let v0 = ReservationsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ReservationsKey>(&arg0.id, v0)) {
            return false
        };
        let v1 = 0;
        let v2 = false;
        let v3 = ReservationsKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<ReservationsKey, Reservations>(&mut arg0.id, v3);
        if (!0x2::table::contains<address, vector<u64>>(&v4.held, arg1)) {
            return false
        };
        let v5 = 0x2::table::borrow_mut<address, vector<u64>>(&mut v4.held, arg1);
        while (!0x1::vector::is_empty<u64>(v5) && !v2) {
            let v6 = 0x1::vector::remove<u64>(v5, 0);
            if (!0x2::table::contains<u64, Reservation>(&v4.queue, v6)) {
                continue
            };
            let v7 = 0x2::table::borrow_mut<u64, Reservation>(&mut v4.queue, v6);
            if (!v7.live) {
                continue
            };
            v7.live = false;
            if (v7.until > arg2) {
                v2 = true;
                continue
            };
            v1 = v1 + 1;
        };
        let v8 = if (v2) {
            1
        } else {
            0
        };
        arg0.reserved = arg0.reserved - v1 - v8;
        if (v2) {
            let v9 = ReservationUsed{
                wallet   : arg1,
                reserved : arg0.reserved,
            };
            0x2::event::emit<ReservationUsed>(v9);
        };
        v2
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

    public(friend) fun wear(arg0: &mut Shovel, arg1: u64, arg2: u64) {
        arg0.durability = arg0.durability - arg1;
        arg0.dug = arg0.dug + arg2;
    }

    // decompiled from Move bytecode v7
}

