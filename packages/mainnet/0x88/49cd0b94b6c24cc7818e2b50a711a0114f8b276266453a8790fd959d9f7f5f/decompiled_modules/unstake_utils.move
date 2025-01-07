module 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils {
    struct UnstakeInfo has copy, drop, store {
        epoch: u64,
        amount: u64,
    }

    struct UnstakePayload has copy, drop, store {
        validator: address,
        unstakes: vector<UnstakeInfo>,
    }

    public fun borrow_mut_unstakes(arg0: &mut UnstakePayload) : &mut vector<UnstakeInfo> {
        &mut arg0.unstakes
    }

    public fun load_unstake_info_amount(arg0: &UnstakeInfo) : u64 {
        arg0.amount
    }

    public fun load_unstake_info_epoch(arg0: &UnstakeInfo) : u64 {
        arg0.epoch
    }

    public fun load_unstakes(arg0: &UnstakePayload) : &vector<UnstakeInfo> {
        &arg0.unstakes
    }

    public fun load_validator(arg0: &UnstakePayload) : address {
        arg0.validator
    }

    public fun make_empty_payload(arg0: address) : UnstakePayload {
        UnstakePayload{
            validator : arg0,
            unstakes  : 0x1::vector::empty<UnstakeInfo>(),
        }
    }

    public fun make_payload(arg0: vector<u64>, arg1: vector<u64>, arg2: address) : UnstakePayload {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 0);
        let v1 = 0x1::vector::empty<UnstakeInfo>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = UnstakeInfo{
                epoch  : *0x1::vector::borrow<u64>(&arg0, v2),
                amount : *0x1::vector::borrow<u64>(&arg1, v2),
            };
            0x1::vector::push_back<UnstakeInfo>(&mut v1, v3);
            v2 = v2 + 1;
        };
        UnstakePayload{
            validator : arg2,
            unstakes  : v1,
        }
    }

    public fun make_unstake_info(arg0: u64, arg1: u64) : UnstakeInfo {
        UnstakeInfo{
            epoch  : arg0,
            amount : arg1,
        }
    }

    public fun total_sui_to_unstake(arg0: &UnstakePayload) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<UnstakeInfo>(&arg0.unstakes)) {
            v1 = v1 + 0x1::vector::borrow<UnstakeInfo>(&arg0.unstakes, v0).amount;
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

