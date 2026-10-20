module 0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::withdrawal {
    struct Withdrawal has copy, drop {
        id: u64,
        domain: u64,
        vault: vector<u8>,
        token: vector<u8>,
        recipient: address,
        amount: u64,
        deadline: u64,
        fee: u64,
        memo: vector<u8>,
    }

    struct Proof has copy, drop {
        data: vector<u8>,
        recv_sequence: u64,
        witness: vector<u8>,
        action_siblings: vector<vector<u8>>,
        action_left: vector<bool>,
        major_version: u32,
        minor_version: u32,
        block_num: u32,
        timestamp: u32,
        parent_timestamp: u32,
        finality_digest: vector<u8>,
        tree_siblings: vector<vector<u8>>,
        tree_left: vector<bool>,
    }

    fun act_digest(arg0: u64, arg1: &vector<u8>) : vector<u8> {
        let v0 = le64(arg0);
        0x1::vector::append<u8>(&mut v0, le64(16312959241080012800));
        0x1::vector::append<u8>(&mut v0, uleb(1));
        0x1::vector::append<u8>(&mut v0, le64(arg0));
        0x1::vector::append<u8>(&mut v0, le64(3617214756542218240));
        let v1 = uleb(0x1::vector::length<u8>(arg1));
        0x1::vector::append<u8>(&mut v1, *arg1);
        0x1::vector::append<u8>(&mut v1, uleb(0));
        let v2 = 0x1::hash::sha2_256(v0);
        0x1::vector::append<u8>(&mut v2, 0x1::hash::sha2_256(v1));
        0x1::hash::sha2_256(v2)
    }

    public fun amount(arg0: &Withdrawal) : u64 {
        arg0.amount
    }

    public fun deadline(arg0: &Withdrawal) : u64 {
        arg0.deadline
    }

    public(friend) fun decode(arg0: vector<u8>) : Withdrawal {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v2 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v3 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v4 = if (0x1::vector::length<u8>(&v1) == 32) {
            if (0x1::vector::length<u8>(&v2) == 32) {
                0x1::vector::length<u8>(&v3) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 5);
        let v5 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v5), 4);
        Withdrawal{
            id        : 0x2::bcs::peel_u64(&mut v0),
            domain    : 0x2::bcs::peel_u64(&mut v0),
            vault     : v1,
            token     : v2,
            recipient : 0x2::address::from_bytes(v3),
            amount    : 0x2::bcs::peel_u64(&mut v0),
            deadline  : 0x2::bcs::peel_u64(&mut v0),
            fee       : 0x2::bcs::peel_u64(&mut v0),
            memo      : 0x2::bcs::peel_vec_u8(&mut v0),
        }
    }

    public fun domain(arg0: &Withdrawal) : u64 {
        arg0.domain
    }

    public fun fee(arg0: &Withdrawal) : u64 {
        arg0.fee
    }

    fun fold(arg0: vector<u8>, arg1: &vector<vector<u8>>, arg2: &vector<bool>) : vector<u8> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg1)) {
            let v1 = *0x1::vector::borrow<vector<u8>>(arg1, v0);
            assert!(0x1::vector::length<u8>(&v1) == 32, 1);
            let v2 = if (*0x1::vector::borrow<bool>(arg2, v0)) {
                let v2 = arg0;
                0x1::vector::append<u8>(&mut v2, v1);
                v2
            } else {
                let v2 = v1;
                0x1::vector::append<u8>(&mut v2, arg0);
                v2
            };
            arg0 = 0x1::hash::sha2_256(v2);
            v0 = v0 + 1;
        };
        arg0
    }

    public fun id(arg0: &Withdrawal) : u64 {
        arg0.id
    }

    fun le32(arg0: u32) : vector<u8> {
        0x2::bcs::to_bytes<u32>(&arg0)
    }

    fun le64(arg0: u64) : vector<u8> {
        0x2::bcs::to_bytes<u64>(&arg0)
    }

    public fun memo(arg0: &Withdrawal) : vector<u8> {
        arg0.memo
    }

    public fun proof(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<bool>, arg5: u32, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: vector<u8>, arg11: vector<vector<u8>>, arg12: vector<bool>) : Proof {
        assert!(0x1::vector::length<u8>(&arg2) == 32 && 0x1::vector::length<u8>(&arg10) == 32, 1);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<bool>(&arg4), 2);
        assert!(0x1::vector::length<vector<u8>>(&arg11) == 0x1::vector::length<bool>(&arg12), 2);
        Proof{
            data             : arg0,
            recv_sequence    : arg1,
            witness          : arg2,
            action_siblings  : arg3,
            action_left      : arg4,
            major_version    : arg5,
            minor_version    : arg6,
            block_num        : arg7,
            timestamp        : arg8,
            parent_timestamp : arg9,
            finality_digest  : arg10,
            tree_siblings    : arg11,
            tree_left        : arg12,
        }
    }

    public fun prove(arg0: &0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client::TelosClient, arg1: u64, arg2: &Proof) : Withdrawal {
        let v0 = root_of(arg1, arg2);
        assert!(0xa54ae2d117e5a6aebd8d7aadc019f7ef1d69a7bd13fc1e4b0d14c29e4f478772::telos_client::is_trusted(arg0, &v0), 3);
        decode(arg2.data)
    }

    public fun recipient(arg0: &Withdrawal) : address {
        arg0.recipient
    }

    public fun root_of(arg0: u64, arg1: &Proof) : vector<u8> {
        let v0 = le64(arg0);
        0x1::vector::append<u8>(&mut v0, le64(arg1.recv_sequence));
        0x1::vector::append<u8>(&mut v0, le64(arg0));
        0x1::vector::append<u8>(&mut v0, le64(16312959241080012800));
        0x1::vector::append<u8>(&mut v0, act_digest(arg0, &arg1.data));
        0x1::vector::append<u8>(&mut v0, arg1.witness);
        let v1 = le32(arg1.major_version);
        0x1::vector::append<u8>(&mut v1, le32(arg1.minor_version));
        0x1::vector::append<u8>(&mut v1, le32(arg1.block_num));
        0x1::vector::append<u8>(&mut v1, le32(arg1.timestamp));
        0x1::vector::append<u8>(&mut v1, le32(arg1.parent_timestamp));
        0x1::vector::append<u8>(&mut v1, arg1.finality_digest);
        0x1::vector::append<u8>(&mut v1, fold(0x1::hash::sha2_256(v0), &arg1.action_siblings, &arg1.action_left));
        fold(0x1::hash::sha2_256(v1), &arg1.tree_siblings, &arg1.tree_left)
    }

    public fun token(arg0: &Withdrawal) : vector<u8> {
        arg0.token
    }

    fun uleb(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1;
        loop {
            v1 = ((arg0 & 127) as u8);
            arg0 = arg0 >> 7;
            if (arg0 == 0) {
                break
            };
            0x1::vector::push_back<u8>(&mut v0, v1 | 128);
        };
        0x1::vector::push_back<u8>(&mut v0, v1);
        v0
    }

    public fun vault(arg0: &Withdrawal) : vector<u8> {
        arg0.vault
    }

    // decompiled from Move bytecode v7
}

