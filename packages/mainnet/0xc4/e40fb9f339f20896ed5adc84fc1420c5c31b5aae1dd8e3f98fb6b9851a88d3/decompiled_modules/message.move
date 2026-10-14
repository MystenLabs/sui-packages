module 0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::message {
    struct Vault has copy, drop, store {
        raw: u64,
        multiplier: u128,
        slot: u64,
    }

    fun addr_at(arg0: &vector<u8>, arg1: u64) : address {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        0x2::address::from_bytes(v0)
    }

    fun be_u256(arg0: &vector<u8>, arg1: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    fun be_u32(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 4) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun burn_body(arg0: address, arg1: u64, arg2: address, arg3: u64, arg4: vector<u8>) : vector<u8> {
        let v0 = x"00000001";
        let v1 = b"";
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v0, v1);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        let v3 = &mut v0;
        push_be_u256(v3, (arg1 as u256));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        let v4 = &mut v0;
        push_be_u256(v4, 0);
        let v5 = &mut v0;
        push_be_u256(v5, (arg3 as u256));
        let v6 = &mut v0;
        push_be_u256(v6, 0);
        0x1::vector::append<u8>(&mut v0, arg4);
        v0
    }

    public fun burn_fields(arg0: &vector<u8>) : (address, u64, address, u64, vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) >= 228 && be_u32(arg0, 0) == 1, 200);
        let v0 = be_u256(arg0, 68);
        let v1 = be_u256(arg0, 164);
        assert!(v0 <= 18446744073709551615 && v1 <= v0, 200);
        let v2 = b"";
        let v3 = 228;
        while (v3 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v3));
            v3 = v3 + 1;
        };
        (addr_at(arg0, 36), (v0 as u64), addr_at(arg0, 100), (v1 as u64), v2)
    }

    public fun buy_hook(arg0: u64, arg1: address, arg2: address, arg3: u64, arg4: address, arg5: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, kind_buy());
        let v2 = &mut v0;
        push_u64(v2, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        let v3 = &mut v0;
        push_u64(v3, arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg4));
        let v4 = &mut v0;
        push_u64(v4, arg5);
        assert!(0x1::vector::length<u8>(&v0) == 122, 200);
        v0
    }

    public fun cancelled_body(arg0: u64, arg1: address, arg2: Vault) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, kind_cancelled());
        let v2 = &mut v0;
        push_u64(v2, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        let v3 = &mut v0;
        push_u64(v3, arg2.raw);
        let v4 = &mut v0;
        push_u128(v4, arg2.multiplier);
        let v5 = &mut v0;
        push_u64(v5, arg2.slot);
        v0
    }

    public fun cancelled_fields(arg0: &vector<u8>) : (u64, address, Vault) {
        assert!(is(arg0, kind_cancelled(), 74), 200);
        let v0 = Vault{
            raw        : le_u64(arg0, 42),
            multiplier : le_u128(arg0, 50),
            slot       : le_u64(arg0, 66),
        };
        (le_u64(arg0, 2), addr_at(arg0, 10), v0)
    }

    public fun fill_body(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: Vault) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, kind_fill());
        let v2 = &mut v0;
        push_u64(v2, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        let v3 = &mut v0;
        push_u64(v3, arg2);
        let v4 = &mut v0;
        push_u128(v4, arg5.multiplier);
        let v5 = &mut v0;
        push_u64(v5, arg3);
        let v6 = &mut v0;
        push_u64(v6, arg4);
        let v7 = &mut v0;
        push_u64(v7, arg5.raw);
        let v8 = &mut v0;
        push_u64(v8, arg5.slot);
        v0
    }

    public fun fill_fields(arg0: &vector<u8>) : (u64, address, u64, u64, u64, Vault) {
        assert!(is(arg0, kind_fill(), 98), 200);
        let v0 = Vault{
            raw        : le_u64(arg0, 82),
            multiplier : le_u128(arg0, 50),
            slot       : le_u64(arg0, 90),
        };
        (le_u64(arg0, 2), addr_at(arg0, 10), le_u64(arg0, 42), le_u64(arg0, 66), le_u64(arg0, 74), v0)
    }

    public fun home_hook(arg0: &vector<u8>) : (u8, u64, address) {
        assert!(is(arg0, kind_refund(), 42) || is(arg0, kind_sale(), 82), 200);
        (*0x1::vector::borrow<u8>(arg0, 1), le_u64(arg0, 2), addr_at(arg0, 10))
    }

    fun is(arg0: &vector<u8>, arg1: u8, arg2: u64) : bool {
        if (0x1::vector::length<u8>(arg0) == arg2) {
            if (*0x1::vector::borrow<u8>(arg0, 0) == 2) {
                *0x1::vector::borrow<u8>(arg0, 1) == arg1
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun kind_buy() : u8 {
        1
    }

    public fun kind_cancelled() : u8 {
        6
    }

    public fun kind_fill() : u8 {
        4
    }

    public fun kind_of(arg0: &vector<u8>) : u8 {
        if (0x1::vector::length<u8>(arg0) >= 2 && *0x1::vector::borrow<u8>(arg0, 0) == 2) {
            *0x1::vector::borrow<u8>(arg0, 1)
        } else {
            0
        }
    }

    public fun kind_refund() : u8 {
        2
    }

    public fun kind_report() : u8 {
        7
    }

    public fun kind_sale() : u8 {
        3
    }

    public fun kind_sell() : u8 {
        5
    }

    fun le_u128(arg0: &vector<u8>, arg1: u64) : u128 {
        let v0 = 0;
        let v1 = 16;
        while (v1 > 0) {
            let v2 = v1 - 1;
            v1 = v2;
            let v3 = v0 << 8;
            v0 = v3 | (*0x1::vector::borrow<u8>(arg0, arg1 + v2) as u128);
        };
        v0
    }

    fun le_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 8;
        while (v1 > 0) {
            let v2 = v1 - 1;
            v1 = v2;
            let v3 = v0 << 8;
            v0 = v3 | (*0x1::vector::borrow<u8>(arg0, arg1 + v2) as u64);
        };
        v0
    }

    fun push_be_u256(arg0: &mut vector<u8>, arg1: u256) {
        let v0 = 32;
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            0x1::vector::push_back<u8>(arg0, ((arg1 >> ((8 * v1) as u8) & 255) as u8));
        };
    }

    fun push_u128(arg0: &mut vector<u8>, arg1: u128) {
        let v0 = 0;
        while (v0 < 16) {
            0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 * v0 & 255) as u8));
            v0 = v0 + 1;
        };
    }

    fun push_u64(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0;
        while (v0 < 8) {
            0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 * v0 & 255) as u8));
            v0 = v0 + 1;
        };
    }

    public fun refund_hook(arg0: u64, arg1: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, kind_refund());
        let v2 = &mut v0;
        push_u64(v2, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        v0
    }

    public fun report_body(arg0: address, arg1: Vault, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, kind_report());
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        let v2 = &mut v0;
        push_u64(v2, arg1.raw);
        let v3 = &mut v0;
        push_u128(v3, arg1.multiplier);
        let v4 = &mut v0;
        push_u64(v4, arg2);
        let v5 = &mut v0;
        push_u64(v5, arg3);
        let v6 = &mut v0;
        push_u64(v6, arg4);
        let v7 = &mut v0;
        push_u64(v7, arg1.slot);
        v0
    }

    public fun report_fields(arg0: &vector<u8>) : (address, Vault, u64, u64, u64) {
        assert!(is(arg0, kind_report(), 90), 200);
        let v0 = Vault{
            raw        : le_u64(arg0, 34),
            multiplier : le_u128(arg0, 42),
            slot       : le_u64(arg0, 82),
        };
        (addr_at(arg0, 2), v0, le_u64(arg0, 58), le_u64(arg0, 66), le_u64(arg0, 74))
    }

    public fun sale_fields(arg0: &vector<u8>) : (u64, Vault) {
        assert!(is(arg0, kind_sale(), 82), 200);
        let v0 = Vault{
            raw        : le_u64(arg0, 50),
            multiplier : le_u128(arg0, 58),
            slot       : le_u64(arg0, 74),
        };
        (le_u64(arg0, 42), v0)
    }

    public fun sale_hook(arg0: u64, arg1: address, arg2: u64, arg3: Vault) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, kind_sale());
        let v2 = &mut v0;
        push_u64(v2, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        let v3 = &mut v0;
        push_u64(v3, arg2);
        let v4 = &mut v0;
        push_u64(v4, arg3.raw);
        let v5 = &mut v0;
        push_u128(v5, arg3.multiplier);
        let v6 = &mut v0;
        push_u64(v6, arg3.slot);
        v0
    }

    public fun sell_body(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, kind_sell());
        let v2 = &mut v0;
        push_u64(v2, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        let v3 = &mut v0;
        push_u64(v3, arg2);
        let v4 = &mut v0;
        push_u64(v4, arg3);
        let v5 = &mut v0;
        push_u64(v5, arg4);
        assert!(0x1::vector::length<u8>(&v0) == 66, 200);
        v0
    }

    public fun vault(arg0: u64, arg1: u128, arg2: u64) : Vault {
        Vault{
            raw        : arg0,
            multiplier : arg1,
            slot       : arg2,
        }
    }

    public fun vault_fields(arg0: &Vault) : (u64, u128, u64) {
        (arg0.raw, arg0.multiplier, arg0.slot)
    }

    public fun version() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

