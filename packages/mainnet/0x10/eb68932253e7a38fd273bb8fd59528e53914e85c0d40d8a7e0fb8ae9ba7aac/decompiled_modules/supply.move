module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::supply {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        sets: 0x2::table::Table<0x1::string::String, bool>,
        revoked_ops: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        daily_quota: u64,
        minted_today: u64,
        day: u64,
    }

    struct SetSupply has key {
        id: 0x2::object::UID,
        version: u64,
        set_id: 0x1::string::String,
        caps: 0x2::table::Table<0x1::string::String, u64>,
        minted: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct HousePool has key {
        id: 0x2::object::UID,
        version: u64,
        cards: 0x2::table::Table<u64, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>,
        next_idx: u64,
        count: u64,
    }

    struct CapSet has copy, drop {
        set_id: 0x1::string::String,
        card_id: 0x1::string::String,
        cap: u64,
    }

    struct Minted has copy, drop {
        card_id: 0x1::string::String,
        serial: u64,
        to_house: bool,
    }

    struct OpeningPaused has copy, drop, store {
        dummy_field: bool,
    }

    fun assert_card_in_set(arg0: &0x1::string::String, arg1: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::string::as_bytes(arg1);
        let v2 = 0x1::vector::length<u8>(v0);
        assert!(0x1::vector::length<u8>(v1) > v2 + 1, 5);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(v1, v3) == *0x1::vector::borrow<u8>(v0, v3), 5);
            v3 = v3 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(v1, v2) == 45, 5);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 0);
    }

    public(friend) fun can_mint(arg0: &SetSupply, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, u64>(&arg0.caps, arg1) && minted_of(arg0, arg1) < *0x2::table::borrow<0x1::string::String, u64>(&arg0.caps, arg1) || true
    }

    public fun cap_of(arg0: &SetSupply, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.caps, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.caps, arg1)
        } else {
            0
        }
    }

    public fun has_cap(arg0: &SetSupply, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, u64>(&arg0.caps, arg1)
    }

    public fun house_count(arg0: &HousePool) : u64 {
        arg0.count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id          : 0x2::object::new(arg0),
            version     : 1,
            sets        : 0x2::table::new<0x1::string::String, bool>(arg0),
            revoked_ops : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_opening_paused(arg0: &SetSupply) : bool {
        let v0 = OpeningPaused{dummy_field: false};
        0x2::dynamic_field::exists<OpeningPaused>(&arg0.id, v0)
    }

    public fun issue_operator(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{
            id           : 0x2::object::new(arg3),
            daily_quota  : arg1,
            minted_today : 0,
            day          : 0,
        };
        0x2::transfer::public_transfer<OperatorCap>(v0, arg2);
    }

    public fun migrate_house(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut HousePool) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public fun migrate_registry(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut Registry) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public fun migrate_supply(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut SetSupply) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public(friend) fun mint_from_pack(arg0: &mut SetSupply, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = next_serial(arg0, arg1);
        0x2::transfer::public_transfer<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::mint(arg0.set_id, arg1, arg2, v0, arg3, arg4, arg6), arg5);
        let v1 = Minted{
            card_id  : arg1,
            serial   : v0,
            to_house : false,
        };
        0x2::event::emit<Minted>(v1);
        v0
    }

    public fun mint_to_house(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut SetSupply, arg2: &mut HousePool, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg2.version);
        let v0 = next_serial(arg1, arg3);
        0x2::table::add<u64, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(&mut arg2.cards, arg2.next_idx, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::mint(arg1.set_id, arg3, arg4, v0, arg5, arg6, arg7));
        arg2.next_idx = arg2.next_idx + 1;
        arg2.count = arg2.count + 1;
        let v1 = Minted{
            card_id  : arg3,
            serial   : v0,
            to_house : true,
        };
        0x2::event::emit<Minted>(v1);
    }

    public fun mint_to_player(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut SetSupply, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = next_serial(arg1, arg2);
        0x2::transfer::public_transfer<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::mint(arg1.set_id, arg2, arg3, v0, arg4, arg5, arg7), arg6);
        let v1 = Minted{
            card_id  : arg2,
            serial   : v0,
            to_house : false,
        };
        0x2::event::emit<Minted>(v1);
    }

    public fun minted_of(arg0: &SetSupply, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.minted, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.minted, arg1)
        } else {
            0
        }
    }

    public fun new_house_pool(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HousePool{
            id       : 0x2::object::new(arg1),
            version  : 1,
            cards    : 0x2::table::new<u64, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(arg1),
            next_idx : 0,
            count    : 0,
        };
        0x2::transfer::share_object<HousePool>(v0);
    }

    public fun new_set_supply(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut Registry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1.version);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.sets, arg2), 8);
        0x2::table::add<0x1::string::String, bool>(&mut arg1.sets, arg2, true);
        let v0 = SetSupply{
            id      : 0x2::object::new(arg3),
            version : 1,
            set_id  : arg2,
            caps    : 0x2::table::new<0x1::string::String, u64>(arg3),
            minted  : 0x2::table::new<0x1::string::String, u64>(arg3),
        };
        0x2::transfer::share_object<SetSupply>(v0);
    }

    fun next_serial(arg0: &mut SetSupply, arg1: 0x1::string::String) : u64 {
        assert_version(arg0.version);
        assert_card_in_set(&arg0.set_id, &arg1);
        let v0 = minted_of(arg0, arg1);
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.caps, arg1)) {
            assert!(v0 < *0x2::table::borrow<0x1::string::String, u64>(&arg0.caps, arg1), 1);
        };
        let v1 = v0 + 1;
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.minted, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.minted, arg1) = v1;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.minted, arg1, v1);
        };
        v1
    }

    public fun operator_mint_to_player(arg0: &mut OperatorCap, arg1: &Registry, arg2: &0x2::clock::Clock, arg3: &mut SetSupply, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1.version);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg1.revoked_ops, 0x2::object::id<OperatorCap>(arg0)), 6);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 86400000;
        if (arg0.day != v0) {
            arg0.day = v0;
            arg0.minted_today = 0;
        };
        assert!(arg0.minted_today < arg0.daily_quota, 7);
        arg0.minted_today = arg0.minted_today + 1;
        let v1 = next_serial(arg3, arg4);
        0x2::transfer::public_transfer<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::mint(arg3.set_id, arg4, arg5, v1, arg6, arg7, arg9), arg8);
        let v2 = Minted{
            card_id  : arg4,
            serial   : v1,
            to_house : false,
        };
        0x2::event::emit<Minted>(v2);
    }

    public fun remaining_of(arg0: &SetSupply, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.caps, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.caps, arg1) - minted_of(arg0, arg1)
        } else {
            0
        }
    }

    public fun revoke_operator(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut Registry, arg2: 0x2::object::ID) {
        assert_version(arg1.version);
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg1.revoked_ops, arg2)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.revoked_ops, arg2, true);
        };
    }

    public fun set_cap(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut SetSupply, arg2: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::SetCatalog, arg3: 0x1::string::String, arg4: u64) {
        assert_version(arg1.version);
        assert!(*0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::set_id(arg2) == arg1.set_id, 5);
        let (v0, v1, _) = 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::catalog::find(arg2, &arg3);
        assert!(v0, 5);
        assert!(v1 >= 3, 9);
        assert!(arg4 >= minted_of(arg1, arg3), 3);
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.caps, arg3)) {
            let v3 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg1.caps, arg3);
            assert!(arg4 <= *v3, 2);
            *v3 = arg4;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.caps, arg3, arg4);
        };
        let v4 = CapSet{
            set_id  : arg1.set_id,
            card_id : arg3,
            cap     : arg4,
        };
        0x2::event::emit<CapSet>(v4);
    }

    public fun set_id_of(arg0: &SetSupply) : &0x1::string::String {
        &arg0.set_id
    }

    public fun set_opening_paused(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut SetSupply, arg2: bool) {
        let v0 = OpeningPaused{dummy_field: false};
        let v1 = 0x2::dynamic_field::exists<OpeningPaused>(&arg1.id, v0);
        if (arg2 && !v1) {
            let v2 = OpeningPaused{dummy_field: false};
            0x2::dynamic_field::add<OpeningPaused, bool>(&mut arg1.id, v2, true);
        } else if (!arg2 && v1) {
            let v3 = OpeningPaused{dummy_field: false};
            0x2::dynamic_field::remove<OpeningPaused, bool>(&mut arg1.id, v3);
        };
    }

    public fun withdraw_from_house(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut HousePool, arg2: u64) : 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling {
        assert_version(arg1.version);
        assert!(0x2::table::contains<u64, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(&arg1.cards, arg2), 4);
        arg1.count = arg1.count - 1;
        0x2::table::remove<u64, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(&mut arg1.cards, arg2)
    }

    // decompiled from Move bytecode v7
}

