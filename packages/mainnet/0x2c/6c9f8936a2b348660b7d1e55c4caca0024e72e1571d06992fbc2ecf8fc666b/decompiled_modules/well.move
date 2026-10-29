module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::well {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        well: 0x2::object::ID,
    }

    struct Well has key {
        id: 0x2::object::UID,
        version: u64,
        well_open: bool,
        curses_open: bool,
        candles_open: bool,
        cooldown_ms: u64,
        weights: vector<u64>,
        ward_ms: u64,
        curse_max_ms: u64,
        spirits: 0x2::table::Table<0x2::object::ID, Spirit>,
    }

    struct Spirit has drop, store {
        last_draw_ms: u64,
        cursed_until_ms: u64,
        cursed_by: address,
        warded_until_ms: u64,
        awakened_at_ms: u64,
    }

    struct Drawn has copy, drop {
        grave: 0x2::object::ID,
        number: u64,
        kind: u8,
        luck: u8,
        second: bool,
        to_pocket: bool,
        by: address,
    }

    struct Cursed has copy, drop {
        target: 0x2::object::ID,
        by: address,
        until: u64,
    }

    struct Cured has copy, drop {
        target: 0x2::object::ID,
        by: address,
    }

    struct Warded has copy, drop {
        target: 0x2::object::ID,
        by: address,
        until: u64,
    }

    struct Awakened has copy, drop {
        grave: 0x2::object::ID,
        number: u64,
        by: address,
    }

    struct CandleLit has copy, drop {
        grave: 0x2::object::ID,
        by: address,
        at: u64,
    }

    struct WellConfigured has copy, drop {
        well: 0x2::object::ID,
        well_open: bool,
        curses_open: bool,
        candles_open: bool,
        cooldown_ms: u64,
        weights: vector<u64>,
        ward_ms: u64,
        curse_max_ms: u64,
    }

    fun blank() : Spirit {
        Spirit{
            last_draw_ms    : 0,
            cursed_until_ms : 0,
            cursed_by       : @0x0,
            warded_until_ms : 0,
            awakened_at_ms  : 0,
        }
    }

    public fun candles_open(arg0: &Well) : bool {
        arg0.candles_open
    }

    fun check_admin(arg0: &AdminCap, arg1: &Well) {
        assert!(arg0.well == 0x2::object::id<Well>(arg1), 401);
        check_version(arg1);
    }

    fun check_version(arg0: &Well) {
        assert!(arg0.version == 1, 400);
    }

    fun configured(arg0: &Well) {
        let v0 = WellConfigured{
            well         : 0x2::object::id<Well>(arg0),
            well_open    : arg0.well_open,
            curses_open  : arg0.curses_open,
            candles_open : arg0.candles_open,
            cooldown_ms  : arg0.cooldown_ms,
            weights      : arg0.weights,
            ward_ms      : arg0.ward_ms,
            curse_max_ms : arg0.curse_max_ms,
        };
        0x2::event::emit<WellConfigured>(v0);
    }

    public fun cooldown_ms(arg0: &Well) : u64 {
        arg0.cooldown_ms
    }

    public fun cure(arg0: &mut Well, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = v0 + arg0.ward_ms;
        let v2 = spirit_mut(arg0, arg2);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::use_remedy(arg1);
        if (v2.cursed_until_ms > v0) {
            v2.cursed_until_ms = 0;
            v2.cursed_by = @0x0;
            let v3 = Cured{
                target : arg2,
                by     : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<Cured>(v3);
        } else {
            v2.warded_until_ms = v1;
            let v4 = Warded{
                target : arg2,
                by     : 0x2::tx_context::sender(arg4),
                until  : v1,
            };
            0x2::event::emit<Warded>(v4);
        };
    }

    public fun curse(arg0: &mut Well, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.curses_open, 403);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = if (arg0.curse_max_ms == 0) {
            18446744073709551615
        } else {
            v0 + arg0.curse_max_ms
        };
        let v2 = spirit_mut(arg0, arg2);
        assert!(v2.cursed_until_ms <= v0, 407);
        assert!(v2.warded_until_ms <= v0, 408);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::use_poison(arg1);
        v2.cursed_until_ms = v1;
        v2.cursed_by = 0x2::tx_context::sender(arg4);
        let v3 = Cursed{
            target : arg2,
            by     : 0x2::tx_context::sender(arg4),
            until  : v1,
        };
        0x2::event::emit<Cursed>(v3);
    }

    public fun curse_max_ms(arg0: &Well) : u64 {
        arg0.curse_max_ms
    }

    public fun curses_open(arg0: &Well) : bool {
        arg0.curses_open
    }

    fun deliver<T0: store + key>(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg2: T0, arg3: bool, arg4: address, arg5: &0x2::tx_context::TxContext) {
        if (arg3) {
            0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::pocket::put<T0>(arg0, arg1, arg2, arg5);
        } else {
            0x2::transfer::public_transfer<T0>(arg2, arg4);
        };
    }

    fun draw_all(arg0: &mut Well, arg1: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: vector<0x2::object::ID>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::random::RandomGenerator, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.well_open, 402);
        assert!(0x1::vector::length<0x2::object::ID>(&arg4) <= 25, 406);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg4)) {
            if (draw_one(arg0, arg1, arg2, arg3, *0x1::vector::borrow<0x2::object::ID>(&arg4, v1), 0x2::clock::timestamp_ms(arg5), arg6, arg7)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 405);
    }

    entry fun draw_in_kiosk(arg0: &mut Well, arg1: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: vector<0x2::object::ID>, arg5: &0x2::clock::Clock, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg6, arg7);
        let v1 = &mut v0;
        draw_all(arg0, arg1, arg2, arg3, arg4, arg5, v1, arg7);
    }

    entry fun draw_in_personal_kiosk(arg0: &mut Well, arg1: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: vector<0x2::object::ID>, arg5: &0x2::clock::Clock, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg6, arg7);
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg3);
        let v3 = v1;
        let v4 = &mut v0;
        draw_all(arg0, arg1, arg2, &v3, arg4, arg5, v4, arg7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg3, v3, v2);
    }

    fun draw_one(arg0: &mut Well, arg1: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::random::RandomGenerator, arg7: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x2::kiosk::has_item_with_type<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg2, arg4) || 0x2::kiosk::is_listed(arg2, arg4)) {
            return false
        };
        let v0 = 0x2::kiosk::borrow_mut<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg2, arg3, arg4);
        if (!0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::is_risen(v0)) {
            return false
        };
        if (0x2::table::contains<0x2::object::ID, Spirit>(&arg0.spirits, arg4)) {
            let v1 = 0x2::table::borrow<0x2::object::ID, Spirit>(&arg0.spirits, arg4);
            if (v1.cursed_until_ms > arg5) {
                return false
            };
            if (v1.last_draw_ms != 0 && arg5 < v1.last_draw_ms + arg0.cooldown_ms) {
                return false
            };
        } else {
            0x2::table::add<0x2::object::ID, Spirit>(&mut arg0.spirits, arg4, blank());
        };
        0x2::table::borrow_mut<0x2::object::ID, Spirit>(&mut arg0.spirits, arg4).last_draw_ms = arg5;
        let v2 = if (0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::pocket::is_open(arg1)) {
            0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::pocket::things(v0) < 64
        } else {
            false
        };
        let v3 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_luck_of(v0);
        let (v4, v5) = pick(&arg0.weights, v3, 0x2::random::generate_u64_in_range(arg6, 0, 10000 - 1), 0x2::random::generate_u8_in_range(arg6, 0, 99), 0x2::random::generate_u64_in_range(arg6, 0, 10000 - 1));
        let v6 = 0x2::tx_context::sender(arg7);
        if (v4 == 0) {
            deliver<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(arg1, v0, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::mint_poison(arg7), v2, v6, arg7);
        } else if (v4 == 1) {
            deliver<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(arg1, v0, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::mint_remedy(arg7), v2, v6, arg7);
        } else {
            deliver<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir>(arg1, v0, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::mint_elixir(arg7), v2, v6, arg7);
        };
        let v7 = Drawn{
            grave     : arg4,
            number    : 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_number_of(v0),
            kind      : v4,
            luck      : v3,
            second    : v5,
            to_pocket : v2,
            by        : v6,
        };
        0x2::event::emit<Drawn>(v7);
        true
    }

    public fun drink(arg0: &mut Well, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Elixir, arg2: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::is_risen(arg2), 409);
        let v0 = 0x2::object::id<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg2);
        let v1 = spirit_mut(arg0, v0);
        assert!(v1.awakened_at_ms == 0, 410);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::use_elixir(arg1);
        v1.awakened_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v2 = Awakened{
            grave  : v0,
            number : 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_number_of(arg2),
            by     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Awakened>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Well{
            id           : 0x2::object::new(arg0),
            version      : 1,
            well_open    : false,
            curses_open  : false,
            candles_open : false,
            cooldown_ms  : 1200000,
            weights      : vector[6500, 3470, 30],
            ward_ms      : 43200000,
            curse_max_ms : 86400000,
            spirits      : 0x2::table::new<0x2::object::ID, Spirit>(arg0),
        };
        let v1 = AdminCap{
            id   : 0x2::object::new(arg0),
            well : 0x2::object::id<Well>(&v0),
        };
        0x2::transfer::share_object<Well>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun kind_of(arg0: &vector<u64>, arg1: u64) : u8 {
        let v0 = *0x1::vector::borrow<u64>(arg0, 2);
        let v1 = if (arg1 < v0) {
            1
        } else {
            0
        };
        let v2 = if (arg1 < v0 + *0x1::vector::borrow<u64>(arg0, 1)) {
            1
        } else {
            0
        };
        v1 + v2
    }

    public fun light(arg0: &Well, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.candles_open, 404);
        let v0 = CandleLit{
            grave : arg1,
            by    : 0x2::tx_context::sender(arg3),
            at    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CandleLit>(v0);
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut Well) {
        assert!(arg0.well == 0x2::object::id<Well>(arg1), 401);
        assert!(arg1.version < 1, 400);
        arg1.version = 1;
    }

    public fun next_draw_ms(arg0: &Well, arg1: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x2::object::ID, Spirit>(&arg0.spirits, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, Spirit>(&arg0.spirits, arg1).last_draw_ms;
        if (v0 == 0) {
            0
        } else {
            v0 + arg0.cooldown_ms
        }
    }

    fun pick(arg0: &vector<u64>, arg1: u8, arg2: u64, arg3: u8, arg4: u64) : (u8, bool) {
        let v0 = kind_of(arg0, arg2);
        let v1 = kind_of(arg0, arg4);
        let v2 = arg3 < arg1;
        let v3 = if (v2 && v1 > v0) {
            v1
        } else {
            v0
        };
        (v3, v2)
    }

    entry fun set_candles_open(arg0: &AdminCap, arg1: &mut Well, arg2: bool) {
        check_admin(arg0, arg1);
        arg1.candles_open = arg2;
        configured(arg1);
    }

    entry fun set_cooldown(arg0: &AdminCap, arg1: &mut Well, arg2: u64) {
        check_admin(arg0, arg1);
        assert!(arg2 >= 60000, 412);
        arg1.cooldown_ms = arg2;
        configured(arg1);
    }

    entry fun set_curse_max(arg0: &AdminCap, arg1: &mut Well, arg2: u64) {
        check_admin(arg0, arg1);
        arg1.curse_max_ms = arg2;
        configured(arg1);
    }

    entry fun set_curses_open(arg0: &AdminCap, arg1: &mut Well, arg2: bool) {
        check_admin(arg0, arg1);
        arg1.curses_open = arg2;
        configured(arg1);
    }

    entry fun set_ward(arg0: &AdminCap, arg1: &mut Well, arg2: u64) {
        check_admin(arg0, arg1);
        assert!(arg2 <= 172800000, 413);
        arg1.ward_ms = arg2;
        configured(arg1);
    }

    entry fun set_weights(arg0: &AdminCap, arg1: &mut Well, arg2: u64, arg3: u64, arg4: u64) {
        check_admin(arg0, arg1);
        assert!(arg2 + arg3 + arg4 == 10000 && arg4 <= 100, 411);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg2);
        0x1::vector::push_back<u64>(v1, arg3);
        0x1::vector::push_back<u64>(v1, arg4);
        arg1.weights = v0;
        configured(arg1);
    }

    entry fun set_well_open(arg0: &AdminCap, arg1: &mut Well, arg2: bool) {
        check_admin(arg0, arg1);
        arg1.well_open = arg2;
        configured(arg1);
    }

    public fun spirit(arg0: &Well, arg1: 0x2::object::ID) : (u64, u64, address, u64, u64) {
        if (!0x2::table::contains<0x2::object::ID, Spirit>(&arg0.spirits, arg1)) {
            return (0, 0, @0x0, 0, 0)
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, Spirit>(&arg0.spirits, arg1);
        (v0.last_draw_ms, v0.cursed_until_ms, v0.cursed_by, v0.warded_until_ms, v0.awakened_at_ms)
    }

    fun spirit_mut(arg0: &mut Well, arg1: 0x2::object::ID) : &mut Spirit {
        if (!0x2::table::contains<0x2::object::ID, Spirit>(&arg0.spirits, arg1)) {
            0x2::table::add<0x2::object::ID, Spirit>(&mut arg0.spirits, arg1, blank());
        };
        0x2::table::borrow_mut<0x2::object::ID, Spirit>(&mut arg0.spirits, arg1)
    }

    public fun ward_ms(arg0: &Well) : u64 {
        arg0.ward_ms
    }

    public fun weights(arg0: &Well) : vector<u64> {
        arg0.weights
    }

    public fun well_open(arg0: &Well) : bool {
        arg0.well_open
    }

    // decompiled from Move bytecode v7
}

