module 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::vpt {
    struct ValuePerToken has copy, drop, store {
        sum: u256,
        amount: u256,
    }

    public fun vpt(arg0: u256, arg1: u256) : ValuePerToken {
        let v0 = arg0 > 0 && arg1 == 0;
        assert!(v0 == false, 18301);
        ValuePerToken{
            sum    : arg0,
            amount : arg1,
        }
    }

    public fun add_amount(arg0: &mut ValuePerToken, arg1: u256) {
        let v0 = arg0.amount + arg1;
        let v1 = if (arg0.amount > 0) {
            arg0.sum * v0 / arg0.amount
        } else {
            0
        };
        arg0.sum = v1;
        arg0.amount = v0;
    }

    public fun add_sum(arg0: &mut ValuePerToken, arg1: u256) {
        assert!(arg0.amount > 0, 18301);
        arg0.sum = arg0.sum + arg1;
    }

    public fun amount(arg0: &ValuePerToken) : u256 {
        arg0.amount
    }

    public fun dec_amount(arg0: &mut ValuePerToken, arg1: u256) {
        let v0 = arg0.amount - arg1;
        let v1 = if (arg0.amount > 0) {
            arg0.sum * v0 / arg0.amount
        } else {
            0
        };
        arg0.sum = v1;
        arg0.amount = v0;
    }

    public fun dec_sum(arg0: &mut ValuePerToken, arg1: u256) {
        assert!(arg0.amount > 0, 18301);
        arg0.sum = arg0.sum - arg1;
    }

    public fun diff(arg0: &ValuePerToken, arg1: &ValuePerToken, arg2: u256) : u256 {
        let (v0, v1) = if (arg0.amount == 0 && arg0.sum == 0) {
            (0, 1)
        } else {
            (arg0.sum, arg0.amount)
        };
        let (v2, v3) = if (arg1.amount == 0 && arg1.sum == 0) {
            (0, 1)
        } else {
            (arg1.sum, arg1.amount)
        };
        let v4 = v0 * v3;
        let v5 = v2 * v1;
        if (v4 >= v5) {
            (v4 - v5) * arg2 / v1 * v3
        } else {
            0
        }
    }

    public fun sum(arg0: &ValuePerToken) : u256 {
        arg0.sum
    }

    public fun value(arg0: &ValuePerToken) : u256 {
        if (arg0.sum == 0 && arg0.amount == 0) {
            0
        } else {
            arg0.sum / arg0.amount
        }
    }

    public fun zero() : ValuePerToken {
        vpt(0, 0)
    }

    // decompiled from Move bytecode v6
}

