module 0x4496dd3411b9a3389a7708baa9f384cbc370a2136614685336304359d80bda17::tax_reflection_token {
    struct TAX_REFLECTION_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        total_supply: u64,
        undistributed_tax: u64,
        holders_map: 0x2::table::Table<address, u64>,
        holders_list: vector<address>,
    }

    public entry fun transfer(arg0: &mut TokenRegistry, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, u64>(&arg0.holders_map, v0), 2);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.holders_map, v0);
        assert!(v1 >= arg1, 1);
        let v2 = v1 - arg1;
        if (v2 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.holders_map, v0);
            let v3 = 0x1::vector::length<address>(&arg0.holders_list);
            let v4 = 0;
            while (v4 < v3) {
                if (*0x1::vector::borrow<address>(&arg0.holders_list, v4) == v0) {
                    break
                };
                v4 = v4 + 1;
            };
            if (v4 < v3) {
                0x1::vector::swap<address>(&mut arg0.holders_list, v4, v3 - 1);
                0x1::vector::pop_back<address>(&mut arg0.holders_list);
            };
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.holders_map, v0) = v2;
        };
        let v5 = arg1 * 500 / 10000;
        let v6 = arg1 - v5;
        if (v6 > 0) {
            if (0x2::table::contains<address, u64>(&arg0.holders_map, arg2)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.holders_map, arg2) = *0x2::table::borrow<address, u64>(&arg0.holders_map, arg2) + v6;
            } else {
                0x2::table::add<address, u64>(&mut arg0.holders_map, arg2, v6);
                0x1::vector::push_back<address>(&mut arg0.holders_list, arg2);
            };
        };
        let v7 = arg0.undistributed_tax + v5;
        if (v7 > 0) {
            let v8 = 0x1::vector::empty<address>();
            let v9 = 0;
            while (v9 < 0x1::vector::length<address>(&arg0.holders_list)) {
                0x1::vector::push_back<address>(&mut v8, *0x1::vector::borrow<address>(&arg0.holders_list, v9));
                v9 = v9 + 1;
            };
            let v10 = 0;
            let v11 = 0;
            while (v11 < 0x1::vector::length<address>(&v8)) {
                let v12 = *0x1::vector::borrow<address>(&v8, v11);
                if (0x2::table::contains<address, u64>(&arg0.holders_map, v12)) {
                    let v13 = *0x2::table::borrow<address, u64>(&arg0.holders_map, v12);
                    let v14 = v13 * v7 / (arg0.total_supply - v7);
                    if (v14 > 0) {
                        *0x2::table::borrow_mut<address, u64>(&mut arg0.holders_map, v12) = v13 + v14;
                        v10 = v10 + v14;
                    };
                };
                v11 = v11 + 1;
            };
            arg0.undistributed_tax = v7 - v10;
        };
    }

    public fun balance_of(arg0: &TokenRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.holders_map, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.holders_map, arg1)
        } else {
            0
        }
    }

    public entry fun create_token(arg0: &mut TokenRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_supply == 0, 0);
        arg0.total_supply = arg1;
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::table::add<address, u64>(&mut arg0.holders_map, v0, arg1);
        0x1::vector::push_back<address>(&mut arg0.holders_list, v0);
    }

    public fun holder_count(arg0: &TokenRegistry) : u64 {
        0x1::vector::length<address>(&arg0.holders_list)
    }

    fun init(arg0: TAX_REFLECTION_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRegistry{
            id                : 0x2::object::new(arg1),
            total_supply      : 0,
            undistributed_tax : 0,
            holders_map       : 0x2::table::new<address, u64>(arg1),
            holders_list      : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<TokenRegistry>(v0);
    }

    public fun total_supply(arg0: &TokenRegistry) : u64 {
        arg0.total_supply
    }

    public fun undistributed_tax(arg0: &TokenRegistry) : u64 {
        arg0.undistributed_tax
    }

    // decompiled from Move bytecode v6
}

