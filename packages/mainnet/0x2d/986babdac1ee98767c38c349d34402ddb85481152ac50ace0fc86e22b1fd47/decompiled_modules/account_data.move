module 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data {
    struct WaterXPerp has drop {
        dummy_field: bool,
    }

    struct WaterXPerpData has store {
        positions: 0x2::vec_map::VecMap<0x2::object::ID, vector<u64>>,
        orders: 0x2::vec_map::VecMap<0x2::object::ID, vector<u64>>,
    }

    public fun account_object_address(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID) : address {
        0x2::object::id_to_address(&arg1)
    }

    public fun account_orders(arg0: &WaterXPerpData) : &0x2::vec_map::VecMap<0x2::object::ID, vector<u64>> {
        &arg0.orders
    }

    public fun account_positions(arg0: &WaterXPerpData) : &0x2::vec_map::VecMap<0x2::object::ID, vector<u64>> {
        &arg0.positions
    }

    public(friend) fun add_order(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        ensure_data(arg0, arg1);
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data_mut<WaterXPerp, WaterXPerpData>(arg0, arg1, witness());
        if (!0x2::vec_map::contains<0x2::object::ID, vector<u64>>(&v0.orders, &arg2)) {
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, arg3);
            0x2::vec_map::insert<0x2::object::ID, vector<u64>>(&mut v0.orders, arg2, v1);
        } else {
            0x1::vector::push_back<u64>(0x2::vec_map::get_mut<0x2::object::ID, vector<u64>>(&mut v0.orders, &arg2), arg3);
        };
    }

    public(friend) fun add_position(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        ensure_data(arg0, arg1);
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data_mut<WaterXPerp, WaterXPerpData>(arg0, arg1, witness());
        if (!0x2::vec_map::contains<0x2::object::ID, vector<u64>>(&v0.positions, &arg2)) {
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, arg3);
            0x2::vec_map::insert<0x2::object::ID, vector<u64>>(&mut v0.positions, arg2, v1);
        } else {
            0x1::vector::push_back<u64>(0x2::vec_map::get_mut<0x2::object::ID, vector<u64>>(&mut v0.positions, &arg2), arg3);
        };
    }

    public fun borrow_account(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID) : &WaterXPerpData {
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data<WaterXPerp, WaterXPerpData>(arg0, arg1)
    }

    fun ensure_data(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID) {
        if (0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_data<WaterXPerp>(arg0, arg1)) {
            return
        };
        let v0 = WaterXPerpData{
            positions : 0x2::vec_map::empty<0x2::object::ID, vector<u64>>(),
            orders    : 0x2::vec_map::empty<0x2::object::ID, vector<u64>>(),
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::new_data<WaterXPerp, WaterXPerpData>(arg0, arg1, witness(), v0);
    }

    public fun has_account(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID) : bool {
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_data<WaterXPerp>(arg0, arg1)
    }

    public fun perm_cancel_order() : u32 {
        32
    }

    public fun perm_close_position() : u32 {
        2
    }

    public fun perm_decrease_position() : u32 {
        8
    }

    public fun perm_deposit_collateral() : u32 {
        64
    }

    public fun perm_increase_position() : u32 {
        4
    }

    public fun perm_mint_wlp() : u32 {
        256
    }

    public fun perm_open_position() : u32 {
        1
    }

    public fun perm_place_order() : u32 {
        16
    }

    public fun perm_redeem_wlp() : u32 {
        512
    }

    public fun perm_withdraw_collateral() : u32 {
        128
    }

    public(friend) fun remove_order(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        if (!0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_data<WaterXPerp>(arg0, arg1)) {
            return
        };
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data_mut<WaterXPerp, WaterXPerpData>(arg0, arg1, witness());
        if (!0x2::vec_map::contains<0x2::object::ID, vector<u64>>(&v0.orders, &arg2)) {
            return
        };
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, vector<u64>>(&mut v0.orders, &arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v1)) {
            if (*0x1::vector::borrow<u64>(v1, v2) == arg3) {
                0x1::vector::swap_remove<u64>(v1, v2);
                return
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun remove_position(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        if (!0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_data<WaterXPerp>(arg0, arg1)) {
            return
        };
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::borrow_data_mut<WaterXPerp, WaterXPerpData>(arg0, arg1, witness());
        if (!0x2::vec_map::contains<0x2::object::ID, vector<u64>>(&v0.positions, &arg2)) {
            return
        };
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, vector<u64>>(&mut v0.positions, &arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v1)) {
            if (*0x1::vector::borrow<u64>(v1, v2) == arg3) {
                0x1::vector::swap_remove<u64>(v1, v2);
                return
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun witness() : WaterXPerp {
        WaterXPerp{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

