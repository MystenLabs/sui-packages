module 0xb5764a7bd84eba03803b0089957f5b710291faf5c26cca83bb39eca9100a497::common {
    public(friend) fun kill_tol_normal() : u64 {
        200
    }

    public(friend) fun max_sqrt_price_limit() : u128 {
        79226673515401279992447579055
    }

    public(friend) fun min_sqrt_price_limit() : u128 {
        4295048017
    }

    public(friend) fun mul_bps_u128(arg0: u128, arg1: u64) : u128 {
        (((arg0 as u256) * (arg1 as u256) / 10000) as u128)
    }

    public(friend) fun partial_close_params(arg0: u128, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        push_u64_le(v1, ((arg0 & 18446744073709551615) as u64));
        let v2 = &mut v0;
        push_u64_le(v2, ((arg0 >> 64 & 18446744073709551615) as u64));
        let v3 = &mut v0;
        push_u64_le(v3, arg1);
        let v4 = &mut v0;
        push_u64_le(v4, arg2);
        v0
    }

    public(friend) fun push_bps() : u64 {
        1490
    }

    fun push_u64_le(arg0: &mut vector<u8>, arg1: u64) {
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 0 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 56 & 255) as u8));
    }

    public(friend) fun settle_tol_normal() : u64 {
        200
    }

    public(friend) fun special_params(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        push_u64_le(v1, 0);
        let v2 = &mut v0;
        push_u64_le(v2, 0);
        let v3 = &mut v0;
        push_u64_le(v3, arg0);
        let v4 = &mut v0;
        push_u64_le(v4, 10000);
        v0
    }

    public(friend) fun strategy_add_base() : u8 {
        1
    }

    public(friend) fun strategy_partial_close_minimize() : u8 {
        6
    }

    public(friend) fun strategy_withdraw_minimize() : u8 {
        4
    }

    public(friend) fun tolerance_test_value() : u64 {
        10000
    }

    public(friend) fun vec1<T0>(arg0: T0) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::push_back<T0>(&mut v0, arg0);
        v0
    }

    public(friend) fun withdraw_params(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        push_u64_le(v1, arg0);
        v0
    }

    public(friend) fun work_factor_max() : u64 {
        9000
    }

    public(friend) fun work_id_new() : u64 {
        0
    }

    // decompiled from Move bytecode v7
}

