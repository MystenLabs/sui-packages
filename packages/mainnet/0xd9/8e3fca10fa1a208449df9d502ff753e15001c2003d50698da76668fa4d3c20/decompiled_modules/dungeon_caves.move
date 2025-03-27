module 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_caves {
    struct CavesState has store, key {
        id: 0x2::object::UID,
        total_dgg_yielded: u64,
        total_resident_combating: u64,
        total_resident_rating: u64,
    }

    struct CombatingResident<T0> has store, key {
        id: 0x2::object::UID,
        resident: 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::Resident<T0>,
        start_time: u64,
        owner: address,
    }

    struct Caves has store, key {
        id: 0x2::object::UID,
        combating_residents: 0x2::object_bag::ObjectBag,
        owner_combating_list: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DUNGEON_CAVES has drop {
        dummy_field: bool,
    }

    public fun enter_the_cave<T0: store>(arg0: &mut CavesState, arg1: &mut Caves, arg2: 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::Resident<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = CombatingResident<T0>{
            id         : 0x2::object::new(arg4),
            resident   : arg2,
            start_time : 0x2::clock::timestamp_ms(arg3),
            owner      : v0,
        };
        0x2::object_bag::add<0x2::object::ID, CombatingResident<T0>>(&mut arg1.combating_residents, 0x2::object::id<0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::Resident<T0>>(&arg2), v1);
        let v2 = &mut arg1.owner_combating_list;
        if (0x2::table::contains<address, vector<0x2::object::ID>>(v2, v0)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(v2, v0), 0x2::object::id<CombatingResident<T0>>(&v1));
        } else {
            let v3 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v3, 0x2::object::id<CombatingResident<T0>>(&v1));
            0x2::table::add<address, vector<0x2::object::ID>>(v2, v0, v3);
        };
        arg0.total_resident_combating = arg0.total_resident_combating + 1;
        arg0.total_resident_rating = arg0.total_resident_rating + 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::resident_rating<T0>(&arg2);
    }

    public fun get_user_combating(arg0: &Caves, arg1: address) : vector<0x2::object::ID> {
        let v0 = &arg0.owner_combating_list;
        let v1 = if (0x2::table::contains<address, vector<0x2::object::ID>>(v0, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(v0, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        };
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_event::user_combating_event(v1);
        v1
    }

    fun init(arg0: DUNGEON_CAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = CavesState{
            id                       : 0x2::object::new(arg1),
            total_dgg_yielded        : 0,
            total_resident_combating : 0,
            total_resident_rating    : 0,
        };
        0x2::transfer::share_object<CavesState>(v1);
        let v2 = Caves{
            id                   : 0x2::object::new(arg1),
            combating_residents  : 0x2::object_bag::new(arg1),
            owner_combating_list : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
        };
        0x2::transfer::share_object<Caves>(v2);
    }

    public fun leave_the_cave<T0: store>(arg0: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DungeonVault, arg1: &mut CavesState, arg2: &mut Caves, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let CombatingResident {
            id         : v1,
            resident   : v2,
            start_time : v3,
            owner      : v4,
        } = 0x2::object_bag::remove<0x2::object::ID, CombatingResident<T0>>(&mut arg2.combating_residents, arg3);
        let v5 = v2;
        let v6 = v1;
        assert!(v0 == v4, 0);
        let v7 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::resident_rating<T0>(&v5);
        let v8 = 0x2::object::uid_to_inner(&v6);
        let v9 = &mut arg2.owner_combating_list;
        if (0x2::table::contains<address, vector<0x2::object::ID>>(v9, v0)) {
            let v10 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(v9, v0);
            let (v11, v12) = 0x1::vector::index_of<0x2::object::ID>(v10, &v8);
            if (v11) {
                0x1::vector::remove<0x2::object::ID>(v10, v12);
            };
        };
        let v13 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_utils::getCavesProfitInSec(v7, (0x2::clock::timestamp_ms(arg4) - v3) / 1000);
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::internal_mint(arg0, v13, v4, arg5);
        arg1.total_dgg_yielded = arg1.total_dgg_yielded + v13;
        arg1.total_resident_combating = arg1.total_resident_combating - 1;
        arg1.total_resident_rating = arg1.total_resident_rating - v7;
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::Resident<T0>>(v5, v0);
    }

    // decompiled from Move bytecode v6
}

