module 0x3106674389a685d1326ab410c218c0f1de9aabd8ddb5200138bbb5df78d6a0fc::signed_number {
    struct Number has copy, drop, store {
        value: u64,
        sign: bool,
    }

    public fun add_uint(arg0: Number, arg1: u64) : Number {
        let v0 = arg0.value;
        let v1 = arg0.sign;
        let v2 = v1;
        let v3 = if (v1 == true) {
            v0 + arg1
        } else if (v0 > arg1) {
            v0 - arg1
        } else {
            v2 = true;
            arg1 - v0
        };
        Number{
            value : v3,
            sign  : v2,
        }
    }

    public fun gt_uint(arg0: Number, arg1: u64) : bool {
        !arg0.sign && false || arg0.value > arg1
    }

    public fun lt_uint(arg0: Number, arg1: u64) : bool {
        !arg0.sign || arg0.value < arg1
    }

    public fun new() : Number {
        Number{
            value : 0,
            sign  : true,
        }
    }

    public fun sub_uint(arg0: Number, arg1: u64) : Number {
        let v0 = arg0.value;
        let v1 = arg0.sign;
        let v2 = v1;
        let v3 = if (v1 == false) {
            v0 + arg1
        } else if (v0 > arg1) {
            v0 - arg1
        } else {
            v2 = false;
            arg1 - v0
        };
        Number{
            value : v3,
            sign  : v2,
        }
    }

    public fun value(arg0: Number) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

