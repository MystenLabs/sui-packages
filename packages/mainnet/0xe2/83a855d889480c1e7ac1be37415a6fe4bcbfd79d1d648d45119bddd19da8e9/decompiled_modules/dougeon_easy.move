module 0xe283a855d889480c1e7ac1be37415a6fe4bcbfd79d1d648d45119bddd19da8e9::dougeon_easy {
    struct Dougeon has store, key {
        id: 0x2::object::UID,
        status: 0x2::table::Table<address, PlayerStatus>,
        location: 0x2::table::Table<address, Location>,
    }

    struct PlayerStatus has store {
        status: u64,
    }

    struct Location has store {
        x: u64,
        y: u64,
    }

    struct DougeonEasy has drop {
        dummy_field: bool,
    }

    fun check_encountering_monster(arg0: &mut PlayerStatus, arg1: u64, arg2: u64) : bool {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg1);
        0x1::vector::push_back<u64>(v1, arg2);
        let v2 = vector[vector[0, 6], vector[3, 3], vector[5, 1], vector[5, 5]];
        let v3 = 0x1::vector::contains<vector<u64>>(&v2, &v0);
        if (v3) {
            arg0.status = 1;
        };
        v3
    }

    fun check_wall(arg0: u64, arg1: u64) : bool {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0);
        0x1::vector::push_back<u64>(v1, arg1);
        let v2 = vector[vector[0, 1], vector[0, 2], vector[0, 5], vector[1, 5], vector[3, 0], vector[3, 5], vector[3, 6], vector[3, 7], vector[4, 2], vector[4, 3], vector[4, 4], vector[4, 5], vector[5, 6], vector[6, 3], vector[6, 6], vector[7, 3]];
        0x1::vector::contains<vector<u64>>(&v2, &v0)
    }

    fun create_player(arg0: &mut Dougeon, arg1: address) {
        if (!0x2::table::contains<address, PlayerStatus>(&arg0.status, arg1)) {
            let v0 = PlayerStatus{status: 0};
            0x2::table::add<address, PlayerStatus>(&mut arg0.status, arg1, v0);
            let v1 = Location{
                x : 0,
                y : 0,
            };
            0x2::table::add<address, Location>(&mut arg0.location, arg1, v1);
        };
    }

    public fun get_player_info(arg0: &Dougeon, arg1: address) : vector<u64> {
        if (!0x2::table::contains<address, PlayerStatus>(&arg0.status, arg1)) {
            vector[]
        } else {
            let v1 = 0x1::vector::empty<u64>();
            let v2 = &mut v1;
            0x1::vector::push_back<u64>(v2, 0x2::table::borrow<address, PlayerStatus>(&arg0.status, arg1).status);
            0x1::vector::push_back<u64>(v2, 0x2::table::borrow<address, Location>(&arg0.location, arg1).x);
            0x1::vector::push_back<u64>(v2, 0x2::table::borrow<address, Location>(&arg0.location, arg1).y);
            v1
        }
    }

    entry fun goal(arg0: &mut Dougeon, arg1: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::KapyWorld, arg2: &mut 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::KapyCrew, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow_mut<address, PlayerStatus>(&mut arg0.status, v0);
        assert!(v1.status == 0, invalid_status());
        let v2 = 0x2::table::borrow_mut<address, Location>(&mut arg0.location, v0);
        let v3 = vector[4, 6];
        assert!(v2.x == *0x1::vector::borrow<u64>(&v3, 0) && v2.y == *0x1::vector::borrow<u64>(&v3, 1), no_treasure_box());
        let v4 = DougeonEasy{dummy_field: false};
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::recruit(arg2, 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_pirate::new<DougeonEasy>(arg1, pirate_kind(), v4, arg3));
        v1.status = 2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dougeon{
            id       : 0x2::object::new(arg0),
            status   : 0x2::table::new<address, PlayerStatus>(arg0),
            location : 0x2::table::new<address, Location>(arg0),
        };
        0x2::transfer::share_object<Dougeon>(v0);
    }

    fun invalid_status() : u64 {
        abort 1
    }

    fun invalid_step() : u64 {
        abort 0
    }

    fun invalid_target_location() : u64 {
        abort 2
    }

    fun no_treasure_box() : u64 {
        abort 3
    }

    public fun pirate_kind() : u8 {
        2
    }

    entry fun restart(arg0: &mut Dougeon, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::table::borrow_mut<address, PlayerStatus>(&mut arg0.status, v0);
        assert!(v1.status == 1, invalid_status());
        v1.status = 0;
        let v2 = 0x2::table::borrow_mut<address, Location>(&mut arg0.location, v0);
        v2.x = 0;
        v2.y = 0;
    }

    entry fun walk(arg0: &mut Dougeon, arg1: bool, arg2: bool, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg3 > 0, invalid_step());
        let v0 = 0x2::tx_context::sender(arg4);
        create_player(arg0, v0);
        let v1 = 0x2::table::borrow_mut<address, PlayerStatus>(&mut arg0.status, v0);
        assert!(v1.status == 0, invalid_status());
        let v2 = 0x2::table::borrow_mut<address, Location>(&mut arg0.location, v0);
        if (arg1) {
            if (arg2) {
                assert!(v2.x + arg3 <= 7, invalid_target_location());
            } else {
                assert!(arg3 <= v2.x && v2.x - arg3 >= 0, invalid_target_location());
            };
        } else if (arg2) {
            assert!(v2.y + arg3 <= 7, invalid_target_location());
        } else {
            assert!(arg3 <= v2.y && v2.y - arg3 >= 0, invalid_target_location());
        };
        walk_(v1, v2, arg1, arg2, arg3);
    }

    fun walk_(arg0: &mut PlayerStatus, arg1: &mut Location, arg2: bool, arg3: bool, arg4: u64) {
        while (arg4 > 0) {
            let (v0, v1) = if (arg2) {
                let v2 = if (arg3) {
                    arg1.x + 1
                } else {
                    arg1.x - 1
                };
                (v2, arg1.y)
            } else {
                let v3 = if (arg3) {
                    arg1.y + 1
                } else {
                    arg1.y - 1
                };
                (arg1.x, v3)
            };
            if (check_wall(v0, v1)) {
                break
            };
            arg1.x = v0;
            arg1.y = v1;
            if (check_encountering_monster(arg0, v0, v1)) {
                break
            };
            arg4 = arg4 - 1;
        };
    }

    // decompiled from Move bytecode v6
}

