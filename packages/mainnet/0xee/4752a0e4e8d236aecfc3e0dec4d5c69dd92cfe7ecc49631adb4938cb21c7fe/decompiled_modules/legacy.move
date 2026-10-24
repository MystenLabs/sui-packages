module 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy {
    struct Archive has key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
        count: u64,
        kiosk: 0x2::kiosk::Kiosk,
        cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct State has store {
        archive: 0x2::object::ID,
        frozen: bool,
        inventory_sealed: bool,
        vip: 0x2::table::Table<address, bool>,
        reserved: 0x2::table::Table<u64, u8>,
        claimed: 0x2::table::Table<0x2::object::ID, u64>,
        identities: 0x2::table::Table<0x2::object::ID, u64>,
        art_objects: 0x2::table::Table<u64, 0x2::object::ID>,
        reserved_count: u64,
        skip: vector<u8>,
        index_kind: u8,
        name_prefix: vector<u8>,
        layout_ready: bool,
        display: 0x2::object::ID,
        media_ready: bool,
        king_decimals: 0x1::option::Option<u8>,
    }

    struct LegacyArchived has copy, drop {
        archive: 0x2::object::ID,
        old: 0x2::object::ID,
        index: u64,
        holder: address,
    }

    struct LegacyReleased has copy, drop {
        index: u64,
    }

    struct VipSet has copy, drop {
        wallet: address,
        eligible: bool,
    }

    struct LegacyLayoutSet has copy, drop {
        skip: vector<u8>,
        index_kind: u8,
        name_prefix: vector<u8>,
    }

    struct LegacyIdentityBound has copy, drop {
        old: 0x2::object::ID,
        index: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : State {
        let v0 = 0x2::object::new(arg2);
        let (v1, v2) = 0x2::kiosk::new(arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::object::uid_to_inner(&v0);
        0x2::kiosk::set_owner_custom(&mut v4, &v3, 0x2::object::id_to_address(&v5));
        let v6 = Archive{
            id         : v0,
            collection : arg0,
            count      : 0,
            kiosk      : v4,
            cap        : v3,
        };
        0x2::transfer::share_object<Archive>(v6);
        State{
            archive          : 0x2::object::id<Archive>(&v6),
            frozen           : false,
            inventory_sealed : false,
            vip              : 0x2::table::new<address, bool>(arg2),
            reserved         : 0x2::table::new<u64, u8>(arg2),
            claimed          : 0x2::table::new<0x2::object::ID, u64>(arg2),
            identities       : 0x2::table::new<0x2::object::ID, u64>(arg2),
            art_objects      : 0x2::table::new<u64, 0x2::object::ID>(arg2),
            reserved_count   : 0,
            skip             : b"",
            index_kind       : 0,
            name_prefix      : b"",
            layout_ready     : false,
            display          : arg1,
            media_ready      : false,
            king_decimals    : 0x1::option::none<u8>(),
        }
    }

    public(friend) fun archive<T0: store + key>(arg0: &State, arg1: &mut Archive, arg2: 0x2::object::ID, arg3: T0, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Archive>(arg1) == arg0.archive && arg1.collection == arg2, 227);
        0x2::kiosk::place<T0>(&mut arg1.kiosk, &arg1.cap, arg3);
        arg1.count = arg1.count + 1;
        let v0 = LegacyArchived{
            archive : 0x2::object::id<Archive>(arg1),
            old     : 0x2::object::id<T0>(&arg3),
            index   : arg4,
            holder  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LegacyArchived>(v0);
    }

    public fun archive_count(arg0: &Archive) : u64 {
        arg0.count
    }

    public fun archive_id(arg0: &State) : 0x2::object::ID {
        arg0.archive
    }

    public(friend) fun archive_with_policy<T0: store + key>(arg0: &State, arg1: &mut Archive, arg2: 0x2::object::ID, arg3: T0, arg4: u64, arg5: 0x2::transfer_policy::TransferRequest<T0>, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Archive>(arg1) == arg0.archive && arg1.collection == arg2, 227);
        let v0 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg6);
        let v1 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg6);
        let v2 = if (v0) {
            1
        } else {
            0
        };
        let v3 = if (v1) {
            1
        } else {
            0
        };
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(0x2::transfer_policy::rules<T0>(arg6)) == v2 + v3, 229);
        if (v0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut arg5, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg6, 0x2::transfer_policy::paid<T0>(&arg5)), arg8));
        };
        if (v1) {
            0x2::kiosk::lock<T0>(&mut arg1.kiosk, &arg1.cap, arg6, arg3);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut arg5, &arg1.kiosk);
        } else {
            0x2::kiosk::place<T0>(&mut arg1.kiosk, &arg1.cap, arg3);
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg7) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, 0x2::tx_context::sender(arg8));
        };
        arg1.count = arg1.count + 1;
        let v7 = LegacyArchived{
            archive : 0x2::object::id<Archive>(arg1),
            old     : 0x2::object::id<T0>(&arg3),
            index   : arg4,
            holder  : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<LegacyArchived>(v7);
    }

    public fun assert_authentic<T0>() {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == b"be966a3e13f40dc1a7530e1565315ac707f126f93663873eb986598c7ed06bff::_____king_fizh_____::Nft", 220);
    }

    public(friend) fun assert_media_ready(arg0: &State, arg1: 0x2::object::ID) {
        assert!(arg0.media_ready && arg1 == arg0.display, 222);
    }

    public(friend) fun assert_unfrozen(arg0: &State) {
        assert!(!arg0.frozen, 221);
    }

    public(friend) fun bind_identity(arg0: &mut State, arg1: 0x2::object::ID, arg2: u64) {
        assert_unfrozen(arg0);
        assert!(!arg0.inventory_sealed && 0x2::object::id_to_address(&arg1) != @0x0, 230);
        assert!(is_reserved(arg0, arg2), 223);
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&arg0.identities, arg1) && !0x2::table::contains<u64, 0x2::object::ID>(&arg0.art_objects, arg2), 230);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.identities, arg1, arg2);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.art_objects, arg2, arg1);
        let v0 = LegacyIdentityBound{
            old   : arg1,
            index : arg2,
        };
        0x2::event::emit<LegacyIdentityBound>(v0);
    }

    fun bound_index(arg0: &State, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.identities, arg1), 230);
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.identities, arg1)
    }

    public(friend) fun check_claim(arg0: &State, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        check_claim_window(arg0, arg1, arg2, arg3, arg4, 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::migration_duration_ms());
    }

    public(friend) fun check_claim_window(arg0: &State, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg0.frozen) {
            if (arg3 >= arg4) {
                arg3 < arg4 + arg5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 225);
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&arg0.claimed, arg1), 224);
        assert!(is_reserved(arg0, arg2), 223);
    }

    public(friend) fun configure_layout(arg0: &mut State, arg1: vector<u8>, arg2: u8, arg3: vector<u8>) {
        assert_unfrozen(arg0);
        assert!(0x1::vector::length<u8>(&arg1) <= 32 && arg2 <= 2, 222);
        assert!(0x1::vector::length<u8>(&arg1) > 0 && *0x1::vector::borrow<u8>(&arg1, 0) == 0, 222);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg1)) {
            assert!(*0x1::vector::borrow<u8>(&arg1, v0) <= 8, 222);
            v0 = v0 + 1;
        };
        assert!(arg2 != 1 || 0x1::vector::length<u8>(&arg3) > 0 && 0x1::vector::length<u8>(&arg3) <= 128, 222);
        let v1 = LegacyLayoutSet{
            skip        : arg1,
            index_kind  : arg2,
            name_prefix : arg3,
        };
        0x2::event::emit<LegacyLayoutSet>(v1);
        arg0.skip = arg1;
        arg0.index_kind = arg2;
        arg0.name_prefix = arg3;
        arg0.layout_ready = true;
    }

    public(friend) fun confirm_media(arg0: &mut State, arg1: 0x2::object::ID) {
        assert!(arg1 == arg0.display, 222);
        arg0.media_ready = true;
    }

    fun decimal_name(arg0: vector<u8>, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(&arg0) > 0x1::vector::length<u8>(arg1) && 0x1::vector::length<u8>(&arg0) <= 0x1::vector::length<u8>(arg1) + 4, 222);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v0) == *0x1::vector::borrow<u8>(arg1, v0), 222);
            v0 = v0 + 1;
        };
        let v1 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v0) >= 48 && *0x1::vector::borrow<u8>(&arg0, v0) <= 57, 222);
            let v2 = v1 * 10;
            v1 = v2 + ((*0x1::vector::borrow<u8>(&arg0, v0) - 48) as u64);
            v0 = v0 + 1;
        };
        assert!(v1 > 0 && v1 <= 2100, 222);
        v1
    }

    fun decode_index(arg0: &State, arg1: vector<u8>) : u64 {
        assert!(arg0.layout_ready, 222);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0.skip)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0.skip, v1);
            if (v2 == 0) {
                0x2::bcs::peel_address(&mut v0);
            } else if (v2 == 1) {
                0x2::bcs::peel_u8(&mut v0);
            } else if (v2 == 2) {
                0x2::bcs::peel_u16(&mut v0);
            } else if (v2 == 3) {
                0x2::bcs::peel_u32(&mut v0);
            } else if (v2 == 4) {
                0x2::bcs::peel_u64(&mut v0);
            } else if (v2 == 5) {
                0x2::bcs::peel_u128(&mut v0);
            } else if (v2 == 6) {
                0x2::bcs::peel_u256(&mut v0);
            } else if (v2 == 7) {
                0x2::bcs::peel_bool(&mut v0);
            } else {
                0x2::bcs::peel_vec_u8(&mut v0);
            };
            v1 = v1 + 1;
        };
        let v3 = if (arg0.index_kind == 0) {
            0x2::bcs::peel_u64(&mut v0)
        } else if (arg0.index_kind == 2) {
            (0x2::bcs::peel_u16(&mut v0) as u64)
        } else {
            decimal_name(0x2::bcs::peel_vec_u8(&mut v0), &arg0.name_prefix)
        };
        0x2::bcs::into_remainder_bytes(v0);
        v3
    }

    public fun frozen(arg0: &State) : bool {
        arg0.frozen
    }

    public fun has_migrated(arg0: &State, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, u64>(&arg0.claimed, arg1)
    }

    public fun identity_index(arg0: &State, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.identities, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<0x2::object::ID, u64>(&arg0.identities, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun index<T0: store + key>(arg0: &State, arg1: &T0) : u64 {
        assert_authentic<T0>();
        bound_index(arg0, 0x2::object::id<T0>(arg1))
    }

    public fun is_archived<T0: store + key>(arg0: &Archive, arg1: 0x2::object::ID) : bool {
        0x2::kiosk::has_item_with_type<T0>(&arg0.kiosk, arg1)
    }

    public fun is_reserved(arg0: &State, arg1: u64) : bool {
        0x2::table::contains<u64, u8>(&arg0.reserved, arg1) && *0x2::table::borrow<u64, u8>(&arg0.reserved, arg1) == 0
    }

    public fun is_vip(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.vip, arg1) && *0x2::table::borrow<address, bool>(&arg0.vip, arg1)
    }

    public fun minimum_king(arg0: &State) : u64 {
        minimum_king_for(arg0, 3000000)
    }

    public fun minimum_king_for(arg0: &State, arg1: u64) : u64 {
        assert!(0x1::option::is_some<u8>(&arg0.king_decimals), 222);
        let v0 = (arg1 as u128);
        let v1 = 0;
        while (v1 < *0x1::option::borrow<u8>(&arg0.king_decimals)) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        assert!(v0 <= 18446744073709551615, 222);
        (v0 as u64)
    }

    public(friend) fun record(arg0: &mut State, arg1: 0x2::object::ID, arg2: u64) {
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&arg0.claimed, arg1), 224);
        assert!(is_reserved(arg0, arg2), 223);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.claimed, arg1, arg2);
        *0x2::table::borrow_mut<u64, u8>(&mut arg0.reserved, arg2) = 1;
        arg0.reserved_count = arg0.reserved_count - 1;
    }

    public(friend) fun release(arg0: &mut State, arg1: u64, arg2: u64, arg3: u64) {
        release_window(arg0, arg1, arg2, arg3, 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::migration_duration_ms());
    }

    public(friend) fun release_window(arg0: &mut State, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0.frozen && arg2 >= arg3 + arg4, 226);
        assert!(is_reserved(arg0, arg1), 223);
        *0x2::table::borrow_mut<u64, u8>(&mut arg0.reserved, arg1) = 2;
        arg0.reserved_count = arg0.reserved_count - 1;
        let v0 = LegacyReleased{index: arg1};
        0x2::event::emit<LegacyReleased>(v0);
    }

    public(friend) fun reserve(arg0: &mut State, arg1: u64) {
        assert_unfrozen(arg0);
        assert!(!arg0.inventory_sealed && !0x2::table::contains<u64, u8>(&arg0.reserved, arg1), 223);
        0x2::table::add<u64, u8>(&mut arg0.reserved, arg1, 0);
        arg0.reserved_count = arg0.reserved_count + 1;
    }

    public fun reserved_count(arg0: &State) : u64 {
        arg0.reserved_count
    }

    public(friend) fun seal_configuration(arg0: &mut State) {
        let v0 = if (arg0.layout_ready) {
            if (arg0.inventory_sealed) {
                if (0x1::option::is_some<u8>(&arg0.king_decimals)) {
                    arg0.media_ready
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 222);
        arg0.frozen = true;
    }

    public(friend) fun seal_inventory(arg0: &mut State, arg1: u64) {
        assert_unfrozen(arg0);
        assert!(arg0.reserved_count == arg1, 223);
        assert!(0x2::table::length<0x2::object::ID, u64>(&arg0.identities) == arg1 && 0x2::table::length<u64, 0x2::object::ID>(&arg0.art_objects) == arg1, 230);
        arg0.inventory_sealed = true;
    }

    public(friend) fun set_king_decimals(arg0: &mut State, arg1: u8) {
        assert_unfrozen(arg0);
        assert!(arg1 <= 12, 222);
        arg0.king_decimals = 0x1::option::some<u8>(arg1);
    }

    public(friend) fun set_vip(arg0: &mut State, arg1: vector<address>, arg2: bool) {
        assert!(0x1::vector::length<address>(&arg1) > 0 && 0x1::vector::length<address>(&arg1) <= 100, 228);
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            assert!(v1 != @0x0, 222);
            if (0x2::table::contains<address, bool>(&arg0.vip, v1)) {
                *0x2::table::borrow_mut<address, bool>(&mut arg0.vip, v1) = arg2;
            } else {
                0x2::table::add<address, bool>(&mut arg0.vip, v1, arg2);
            };
            let v2 = VipSet{
                wallet   : v1,
                eligible : arg2,
            };
            0x2::event::emit<VipSet>(v2);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    // decompiled from Move bytecode v7
}

