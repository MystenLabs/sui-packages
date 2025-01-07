module 0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one {
    struct DropList has key {
        id: 0x2::object::UID,
        total_minted: u32,
    }

    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    struct DAY_ONE has drop {
        dummy_field: bool,
    }

    struct DayOne has store, key {
        id: 0x2::object::UID,
        active: bool,
        serial: u32,
    }

    public(friend) fun activate(arg0: &mut DayOne) {
        arg0.active = true;
    }

    fun init(arg0: DAY_ONE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DAY_ONE>(arg0, arg1);
        let v0 = DropList{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
        };
        0x2::transfer::share_object<DropList>(v0);
        let v1 = SetupCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SetupCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_active(arg0: &DayOne) : bool {
        arg0.active
    }

    public fun mint(arg0: &mut DropList, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::to_bytes<vector<address>>(&arg1);
        let v1 = 0x2::dynamic_field::remove_if_exists<address, bool>(&mut arg0.id, 0x2::address::from_bytes(0x2::hash::blake2b256(&v0)));
        assert!(0x1::option::is_some<bool>(&v1), 0);
        let v2 = arg0.total_minted;
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v3 = DayOne{
                id     : 0x2::object::new(arg2),
                active : false,
                serial : v2 + 1,
            };
            0x2::transfer::public_transfer<DayOne>(v3, 0x1::vector::pop_back<address>(&mut arg1));
            v2 = v2 + 1;
        };
        arg0.total_minted = v2;
    }

    public fun setup(arg0: &mut DropList, arg1: SetupCap, arg2: vector<address>) {
        assert!(0x1::vector::length<address>(&arg2) <= 1000, 1);
        let SetupCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::dynamic_field::add<address, bool>(&mut arg0.id, 0x1::vector::pop_back<address>(&mut arg2), true);
        };
    }

    public fun uid(arg0: &DayOne) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut DayOne) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

