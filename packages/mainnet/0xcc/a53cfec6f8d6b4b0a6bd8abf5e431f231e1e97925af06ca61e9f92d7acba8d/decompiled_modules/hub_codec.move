module 0xcca53cfec6f8d6b4b0a6bd8abf5e431f231e1e97925af06ca61e9f92d7acba8d::hub_codec {
    struct HubTransfer has copy, drop, store {
        vault_id: vector<u8>,
        amount: u256,
        account: vector<u8>,
        dest_chain: u32,
        dest_account: vector<u8>,
        request_id: vector<u8>,
        nonce: u64,
        max_fee: u256,
        fee_token: vector<u8>,
        expiry: u64,
    }

    struct WithdrawFill has copy, drop, store {
        request_id: vector<u8>,
        vault_id: vector<u8>,
        amount_out: u256,
        dest_chain: u32,
        dest_account: vector<u8>,
        request_nonce: u64,
        executor: vector<u8>,
        executor_fee: u256,
        expiry: u64,
    }

    fun assert_op(arg0: &vector<u8>, arg1: u8) {
        let v0 = if (*0x1::vector::borrow<u8>(arg0, 0) == 68) {
            if (*0x1::vector::borrow<u8>(arg0, 1) == 65) {
                if (*0x1::vector::borrow<u8>(arg0, 2) == 89) {
                    *0x1::vector::borrow<u8>(arg0, 3) == 72
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(*0x1::vector::borrow<u8>(arg0, 4) == 1, 1);
        assert!(*0x1::vector::borrow<u8>(arg0, 5) == arg1, 2);
    }

    public fun decode_deposit(arg0: vector<u8>) : HubTransfer {
        assert!(0x1::vector::length<u8>(&arg0) == 250, 1);
        assert_op(&arg0, 1);
        decode_transfer(&arg0)
    }

    public fun decode_op(arg0: vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 == 250 || v0 == 218, 1);
        let v1 = if (*0x1::vector::borrow<u8>(&arg0, 0) == 68) {
            if (*0x1::vector::borrow<u8>(&arg0, 1) == 65) {
                if (*0x1::vector::borrow<u8>(&arg0, 2) == 89) {
                    *0x1::vector::borrow<u8>(&arg0, 3) == 72
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        assert!(*0x1::vector::borrow<u8>(&arg0, 4) == 1, 1);
        let v2 = *0x1::vector::borrow<u8>(&arg0, 5);
        let v3 = if (v2 == 1) {
            true
        } else if (v2 == 2) {
            true
        } else {
            v2 == 3
        };
        assert!(v3, 2);
        v2
    }

    fun decode_transfer(arg0: &vector<u8>) : HubTransfer {
        let v0 = 6;
        let v1 = &mut v0;
        let v2 = &mut v0;
        let v3 = &mut v0;
        let v4 = &mut v0;
        let v5 = &mut v0;
        let v6 = &mut v0;
        let v7 = &mut v0;
        let v8 = &mut v0;
        let v9 = &mut v0;
        let v10 = &mut v0;
        HubTransfer{
            vault_id     : take_b32(arg0, v1),
            amount       : take_u256(arg0, v2),
            account      : take_b32(arg0, v3),
            dest_chain   : take_u32(arg0, v4),
            dest_account : take_b32(arg0, v5),
            request_id   : take_b32(arg0, v6),
            nonce        : take_u64(arg0, v7),
            max_fee      : take_u256(arg0, v8),
            fee_token    : take_b32(arg0, v9),
            expiry       : take_u64(arg0, v10),
        }
    }

    public fun decode_withdraw_fill(arg0: vector<u8>) : WithdrawFill {
        assert!(0x1::vector::length<u8>(&arg0) == 218, 1);
        assert_op(&arg0, 3);
        let v0 = 6;
        let v1 = &mut v0;
        let v2 = &mut v0;
        let v3 = &mut v0;
        let v4 = &mut v0;
        let v5 = &mut v0;
        let v6 = &mut v0;
        let v7 = &mut v0;
        let v8 = &mut v0;
        let v9 = &mut v0;
        WithdrawFill{
            request_id    : take_b32(&arg0, v1),
            vault_id      : take_b32(&arg0, v2),
            amount_out    : take_u256(&arg0, v3),
            dest_chain    : take_u32(&arg0, v4),
            dest_account  : take_b32(&arg0, v5),
            request_nonce : take_u64(&arg0, v6),
            executor      : take_b32(&arg0, v7),
            executor_fee  : take_u256(&arg0, v8),
            expiry        : take_u64(&arg0, v9),
        }
    }

    public fun decode_withdraw_request(arg0: vector<u8>) : HubTransfer {
        assert!(0x1::vector::length<u8>(&arg0) == 250, 1);
        assert_op(&arg0, 2);
        decode_transfer(&arg0)
    }

    public fun encode_deposit(arg0: &HubTransfer) : vector<u8> {
        encode_transfer(1, arg0)
    }

    fun encode_transfer(arg0: u8, arg1: &HubTransfer) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        push_header(v1, arg0);
        let v2 = &mut v0;
        push_b32(v2, &arg1.vault_id);
        let v3 = &mut v0;
        push_u256(v3, arg1.amount);
        let v4 = &mut v0;
        push_b32(v4, &arg1.account);
        let v5 = &mut v0;
        push_u32(v5, arg1.dest_chain);
        let v6 = &mut v0;
        push_b32(v6, &arg1.dest_account);
        let v7 = &mut v0;
        push_b32(v7, &arg1.request_id);
        let v8 = &mut v0;
        push_u64(v8, arg1.nonce);
        let v9 = &mut v0;
        push_u256(v9, arg1.max_fee);
        let v10 = &mut v0;
        push_b32(v10, &arg1.fee_token);
        let v11 = &mut v0;
        push_u64(v11, arg1.expiry);
        v0
    }

    public fun encode_withdraw_fill(arg0: &WithdrawFill) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        push_header(v1, 3);
        let v2 = &mut v0;
        push_b32(v2, &arg0.request_id);
        let v3 = &mut v0;
        push_b32(v3, &arg0.vault_id);
        let v4 = &mut v0;
        push_u256(v4, arg0.amount_out);
        let v5 = &mut v0;
        push_u32(v5, arg0.dest_chain);
        let v6 = &mut v0;
        push_b32(v6, &arg0.dest_account);
        let v7 = &mut v0;
        push_u64(v7, arg0.request_nonce);
        let v8 = &mut v0;
        push_b32(v8, &arg0.executor);
        let v9 = &mut v0;
        push_u256(v9, arg0.executor_fee);
        let v10 = &mut v0;
        push_u64(v10, arg0.expiry);
        v0
    }

    public fun encode_withdraw_request(arg0: &HubTransfer) : vector<u8> {
        encode_transfer(2, arg0)
    }

    public fun op_deposit() : u8 {
        1
    }

    public fun op_withdraw_fill() : u8 {
        3
    }

    public fun op_withdraw_request() : u8 {
        2
    }

    fun push_b32(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 32, 1);
        let v0 = 0;
        while (v0 < 32) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun push_header(arg0: &mut vector<u8>, arg1: u8) {
        0x1::vector::push_back<u8>(arg0, 68);
        0x1::vector::push_back<u8>(arg0, 65);
        0x1::vector::push_back<u8>(arg0, 89);
        0x1::vector::push_back<u8>(arg0, 72);
        0x1::vector::push_back<u8>(arg0, 1);
        0x1::vector::push_back<u8>(arg0, arg1);
    }

    fun push_u256(arg0: &mut vector<u8>, arg1: u256) {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((arg1 & 255) as u8));
            arg1 = arg1 >> 8;
            v1 = v1 + 1;
        };
        let v2 = 32;
        while (v2 > 0) {
            let v3 = v2 - 1;
            v2 = v3;
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v3));
        };
    }

    fun push_u32(arg0: &mut vector<u8>, arg1: u32) {
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
    }

    fun push_u64(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 56;
        while (v0 > 0) {
            0x1::vector::push_back<u8>(arg0, ((arg1 >> v0 & 255) as u8));
            v0 = v0 - 8;
        };
        0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
    }

    fun take_b32(arg0: &vector<u8>, arg1: &mut u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, *arg1));
            *arg1 = *arg1 + 1;
            v1 = v1 + 1;
        };
        v0
    }

    fun take_u256(arg0: &vector<u8>, arg1: &mut u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, *arg1) as u256);
            *arg1 = *arg1 + 1;
            v1 = v1 + 1;
        };
        v0
    }

    fun take_u32(arg0: &vector<u8>, arg1: &mut u64) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 4) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, *arg1) as u32);
            *arg1 = *arg1 + 1;
            v1 = v1 + 1;
        };
        v0
    }

    fun take_u64(arg0: &vector<u8>, arg1: &mut u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, *arg1) as u64);
            *arg1 = *arg1 + 1;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

