module 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::rising {
    struct RegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Registry has store {
        pieces: 0x2::table::Table<u64, Piece>,
        piece_size: u64,
        bound: 0x2::table::Table<0x2::object::ID, u64>,
        reserved: u64,
    }

    struct Piece has store {
        name: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        rank: u16,
        pad: vector<u8>,
    }

    struct Seeded has copy, drop {
        collection: 0x2::object::ID,
        from: u64,
        to: u64,
        running_hash: vector<u8>,
    }

    struct Sealed has copy, drop {
        collection: 0x2::object::ID,
        provenance_hash: vector<u8>,
    }

    struct Bound has copy, drop {
        collection: 0x2::object::ID,
        grave: 0x2::object::ID,
        index: u64,
    }

    struct Unbound has copy, drop {
        collection: 0x2::object::ID,
        grave: 0x2::object::ID,
        index: u64,
    }

    struct Risen has copy, drop {
        collection: 0x2::object::ID,
        grave: 0x2::object::ID,
        number: u64,
        index: u64,
        luck: u8,
        second_draw: bool,
    }

    entry fun bind(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::AdminCap, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg2: 0x2::object::ID, arg3: u64) {
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::check_admin(arg0, arg1);
        let (_, _, v2, _, v4) = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::rising_state(arg1);
        assert!(!v4, 301);
        assert!(arg3 >= 1 && arg3 <= v2, 310);
        let v5 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::pool_mut(arg1);
        let v6 = (arg3 as u16);
        let (v7, v8) = 0x1::vector::index_of<u16>(v5, &v6);
        assert!(v7, 310);
        0x1::vector::swap_remove<u16>(v5, v8);
        let v9 = RegistryKey{dummy_field: false};
        let v10 = 0x2::dynamic_field::borrow_mut<RegistryKey, Registry>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::collection_uid_mut(arg1), v9);
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&v10.bound, arg2), 311);
        0x2::table::add<0x2::object::ID, u64>(&mut v10.bound, arg2, arg3);
        v10.reserved = v10.reserved + 1;
        let v11 = Bound{
            collection : 0x2::object::id<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection>(arg1),
            grave      : arg2,
            index      : arg3,
        };
        0x2::event::emit<Bound>(v11);
    }

    public fun bound_index(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::collection_uid(arg0);
        let v1 = RegistryKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RegistryKey>(v0, v1)) {
            return 0x1::option::none<u64>()
        };
        let v2 = RegistryKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<RegistryKey, Registry>(v0, v2);
        if (0x2::table::contains<0x2::object::ID, u64>(&v3.bound, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<0x2::object::ID, u64>(&v3.bound, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    entry fun call_the_dead(arg0: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &0x2::clock::Clock) {
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::check_current(arg0);
        let (_, v1, _, _, v4) = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::rising_state(arg0);
        assert!(v4, 300);
        assert!(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::minted(arg0) == 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::supply(arg0), 309);
        let v5 = 0x2::clock::timestamp_ms(arg1) + 780000;
        if (v5 < v1) {
            0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::move_reveal_start(arg0, v5);
        };
    }

    fun claim_binding(arg0: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = RegistryKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<RegistryKey, Registry>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::collection_uid_mut(arg0), v0);
        if (!0x2::table::contains<0x2::object::ID, u64>(&v1.bound, arg1)) {
            return 0x1::option::none<u64>()
        };
        v1.reserved = v1.reserved - 1;
        0x1::option::some<u64>(*0x2::table::borrow<0x2::object::ID, u64>(&v1.bound, arg1))
    }

    fun draw(arg0: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0x2::random::RandomGenerator, arg2: u8) : (u64, bool) {
        let v0 = 0x1::vector::length<u16>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::pool_mut(arg0));
        assert!(v0 > 0, 307);
        let v1 = if (v0 > 1) {
            v0 - 2
        } else {
            0
        };
        let v2 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::pool_mut(arg0);
        let v3 = (0x1::vector::swap_remove<u16>(v2, 0x2::random::generate_u64_in_range(arg1, 0, v0 - 1)) as u64);
        if (v0 == 1) {
            return (v3, false)
        };
        let v4 = (0x1::vector::swap_remove<u16>(v2, 0x2::random::generate_u64_in_range(arg1, 0, v1)) as u64);
        let v5 = RegistryKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow<RegistryKey, Registry>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::collection_uid(arg0), v5);
        let v7 = 0x2::random::generate_u8_in_range(arg1, 0, 99) < arg2;
        let (v8, v9) = if (v7 && 0x2::table::borrow<u64, Piece>(&v6.pieces, v4).rank < 0x2::table::borrow<u64, Piece>(&v6.pieces, v3).rank) {
            (v4, v3)
        } else {
            (v3, v4)
        };
        0x1::vector::push_back<u16>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::pool_mut(arg0), (v9 as u16));
        (v8, v7)
    }

    fun padded(arg0: Piece, arg1: u64) : Piece {
        let v0 = 0x1::bcs::to_bytes<Piece>(&arg0);
        let v1 = 0x1::vector::length<u8>(&v0) - 1;
        assert!(arg1 > v1, 308);
        let v2 = arg1 - v1 - 1;
        assert!(v2 != 128, 308);
        let v3 = if (v2 < 128) {
            v2
        } else {
            v2 - 1
        };
        assert!(v3 <= 16383, 308);
        let v4 = 0;
        while (v4 < v3) {
            0x1::vector::push_back<u8>(&mut arg0.pad, 0);
            v4 = v4 + 1;
        };
        arg0
    }

    fun rise(arg0: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg2: &0x2::clock::Clock, arg3: &mut 0x2::random::RandomGenerator) {
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::check_current(arg0);
        let (v0, v1, _, _, v4) = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::rising_state(arg0);
        assert!(v4, 300);
        assert!(v0, 306);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1, 304);
        assert!(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_metadata_version(arg1) == 0, 305);
        let v5 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_luck(arg1);
        let v6 = claim_binding(arg0, 0x2::object::id<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg1));
        let (v7, v8) = if (0x1::option::is_some<u64>(&v6)) {
            (0x1::option::destroy_some<u64>(v6), false)
        } else {
            draw(arg0, arg3, v5)
        };
        let v9 = RegistryKey{dummy_field: false};
        let Piece {
            name       : v10,
            attributes : v11,
            rank       : _,
            pad        : v13,
        } = 0x2::table::remove<u64, Piece>(&mut 0x2::dynamic_field::borrow_mut<RegistryKey, Registry>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::collection_uid_mut(arg0), v9).pieces, v7);
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::raise_grave(arg1, v7, v10, v11, v13);
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::count_drawn(arg0);
        let v14 = Risen{
            collection  : 0x2::object::id<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection>(arg0),
            grave       : 0x2::object::id<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg1),
            number      : 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_number(arg1),
            index       : v7,
            luck        : v5,
            second_draw : v8,
        };
        0x2::event::emit<Risen>(v14);
    }

    entry fun rise_in_kiosk(arg0: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg5, arg6);
        let v1 = 0x2::kiosk::borrow_mut<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg1, arg2, arg3);
        let v2 = &mut v0;
        rise(arg0, v1, arg4, v2);
    }

    entry fun rise_in_personal_kiosk(arg0: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg5, arg6);
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v3 = v1;
        let v4 = 0x2::kiosk::borrow_mut<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg1, &v3, arg3);
        let v5 = &mut v0;
        rise(arg0, v4, arg4, v5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v3, v2);
    }

    entry fun seal(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::AdminCap, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg2: vector<u8>) {
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::check_admin(arg0, arg1);
        let (_, _, v2, _, v4) = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::rising_state(arg1);
        assert!(!v4, 301);
        assert!(v2 == 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::supply(arg1), 302);
        assert!(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::running_hash(arg1) == arg2, 303);
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::seal_seeding(arg1, arg2, 0x1::string::utf8(b"mortem-rising-v1: h0 = empty; h(i) = sha3_256(h(i-1) || bcs(index: u64) || bcs(name: String) || bcs(attributes: VecMap<String,String>) || bcs(rank: u16) || bcs(image_sha256: vector<u8>)), index 1..666 in order"));
        let v5 = Sealed{
            collection      : 0x2::object::id<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection>(arg1),
            provenance_hash : arg2,
        };
        0x2::event::emit<Sealed>(v5);
    }

    entry fun seed(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::AdminCap, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg2: u64, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: vector<vector<0x1::string::String>>, arg6: vector<vector<0x1::string::String>>, arg7: vector<u16>, arg8: vector<vector<u8>>, arg9: &mut 0x2::tx_context::TxContext) {
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::check_admin(arg0, arg1);
        let (_, _, v2, _, v4) = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::rising_state(arg1);
        assert!(!v4, 301);
        let v5 = 0x1::vector::length<u64>(&arg3);
        let v6 = if (v5 > 0) {
            if (0x1::vector::length<0x1::string::String>(&arg4) == v5) {
                if (0x1::vector::length<vector<0x1::string::String>>(&arg5) == v5) {
                    0x1::vector::length<vector<0x1::string::String>>(&arg6) == v5
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 302);
        assert!(0x1::vector::length<u16>(&arg7) == v5 && 0x1::vector::length<vector<u8>>(&arg8) == v5, 302);
        assert!(v2 + v5 <= 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::supply(arg1), 302);
        let v7 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::running_hash(arg1);
        let v8 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::collection_uid_mut(arg1);
        let v9 = RegistryKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RegistryKey>(v8, v9)) {
            let v10 = RegistryKey{dummy_field: false};
            let v11 = Registry{
                pieces     : 0x2::table::new<u64, Piece>(arg9),
                piece_size : arg2,
                bound      : 0x2::table::new<0x2::object::ID, u64>(arg9),
                reserved   : 0,
            };
            0x2::dynamic_field::add<RegistryKey, Registry>(v8, v10, v11);
        };
        let v12 = RegistryKey{dummy_field: false};
        let v13 = 0x2::dynamic_field::borrow_mut<RegistryKey, Registry>(v8, v12);
        assert!(v13.piece_size == arg2, 308);
        let v14 = vector[];
        let v15 = 0;
        while (v15 < v5) {
            let v16 = *0x1::vector::borrow<u64>(&arg3, v15);
            assert!(v16 == v2 + 1 + v15, 302);
            let v17 = *0x1::vector::borrow<0x1::string::String>(&arg4, v15);
            let v18 = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(*0x1::vector::borrow<vector<0x1::string::String>>(&arg5, v15), *0x1::vector::borrow<vector<0x1::string::String>>(&arg6, v15));
            let v19 = *0x1::vector::borrow<u16>(&arg7, v15);
            let v20 = v7;
            0x1::vector::append<u8>(&mut v20, 0x1::bcs::to_bytes<u64>(&v16));
            0x1::vector::append<u8>(&mut v20, 0x1::bcs::to_bytes<0x1::string::String>(&v17));
            0x1::vector::append<u8>(&mut v20, 0x1::bcs::to_bytes<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&v18));
            0x1::vector::append<u8>(&mut v20, 0x1::bcs::to_bytes<u16>(&v19));
            0x1::vector::append<u8>(&mut v20, 0x1::bcs::to_bytes<vector<u8>>(0x1::vector::borrow<vector<u8>>(&arg8, v15)));
            v7 = 0x1::hash::sha3_256(v20);
            let v21 = Piece{
                name       : v17,
                attributes : v18,
                rank       : v19,
                pad        : b"",
            };
            0x2::table::add<u64, Piece>(&mut v13.pieces, v16, padded(v21, arg2));
            0x1::vector::push_back<u16>(&mut v14, (v16 as u16));
            v15 = v15 + 1;
        };
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::record_seeds(arg1, v14, v7);
        let v22 = Seeded{
            collection   : 0x2::object::id<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection>(arg1),
            from         : v2 + 1,
            to           : v2 + v5,
            running_hash : v7,
        };
        0x2::event::emit<Seeded>(v22);
    }

    entry fun set_rising_open(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::AdminCap, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg2: bool) {
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::check_admin(arg0, arg1);
        let (_, _, _, _, v4) = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::rising_state(arg1);
        assert!(v4, 300);
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::set_reveal_open(arg1, arg2);
    }

    entry fun unbind(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::AdminCap, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg2: 0x2::object::ID) {
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::check_admin(arg0, arg1);
        let (_, _, _, _, v4) = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::rising_state(arg1);
        assert!(!v4, 301);
        let v5 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::collection_uid_mut(arg1);
        let v6 = RegistryKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RegistryKey>(v5, v6), 312);
        let v7 = RegistryKey{dummy_field: false};
        let v8 = 0x2::dynamic_field::borrow_mut<RegistryKey, Registry>(v5, v7);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v8.bound, arg2), 312);
        let v9 = 0x2::table::remove<0x2::object::ID, u64>(&mut v8.bound, arg2);
        v8.reserved = v8.reserved - 1;
        0x1::vector::push_back<u16>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::pool_mut(arg1), (v9 as u16));
        let v10 = Unbound{
            collection : 0x2::object::id<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection>(arg1),
            grave      : arg2,
            index      : v9,
        };
        0x2::event::emit<Unbound>(v10);
    }

    // decompiled from Move bytecode v7
}

