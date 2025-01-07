module 0x79f8166571bfdc12eff4f82948470b444c21235e25c5d473bd3a80243480e99a::corrective {
    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        recipients: 0x2::table::Table<address, 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>,
    }

    public fun claim_if_exists(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(&arg0.recipients, v0), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(0x2::coin::from_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(0x2::table::remove<address, 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(&mut arg0.recipients, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id         : 0x2::object::new(arg0),
            recipients : 0x2::table::new<address, 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(arg0),
        };
        0x2::transfer::share_object<Pool>(v0);
        let v1 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun safe_claim(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(&arg0.recipients, v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(0x2::coin::from_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(0x2::table::remove<address, 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(&mut arg0.recipients, v0), arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun setup(arg0: &mut Pool, arg1: SetupCap, arg2: vector<address>, arg3: vector<u64>, arg4: 0x2::coin::Coin<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>, arg5: &mut 0x2::tx_context::TxContext) {
        let SetupCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 2);
        let v1 = 0;
        0x1::vector::reverse<u64>(&mut arg3);
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            v1 = v1 + 0x1::vector::pop_back<u64>(&mut arg3);
        };
        0x1::vector::destroy_empty<u64>(arg3);
        assert!(0x2::coin::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&arg4) == v1, 4);
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 9223372290257846271);
        0x1::vector::reverse<address>(&mut arg2);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(!0x2::table::contains<address, 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(&arg0.recipients, v2), 1);
            0x2::table::add<address, 0x2::balance::Balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>>(&mut arg0.recipients, v2, 0x2::coin::into_balance<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(0x2::coin::split<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(&mut arg4, 0x1::vector::pop_back<u64>(&mut arg3), arg5)));
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x2::coin::destroy_zero<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(arg4);
    }

    // decompiled from Move bytecode v6
}

