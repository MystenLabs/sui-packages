module 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::fee {
    struct FeeSettings has key {
        id: 0x2::object::UID,
        recipient: address,
        amount: u64,
    }

    public(friend) fun calculate(arg0: &FeeSettings, arg1: u64) : u64 {
        mul_div_up(arg1, arg0.amount, 1000000000)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeSettings{
            id        : 0x2::object::new(arg0),
            recipient : @0xb1d2f40aa9920d05c3575e3bfd036b770a9de742b635b8df3616df88d023a934,
            amount    : 10000000,
        };
        0x2::transfer::share_object<FeeSettings>(v0);
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        let v3 = if (v0 * v1 % v2 > 0) {
            1
        } else {
            0
        };
        ((v0 * v1 / v2 + v3) as u64)
    }

    public(friend) fun recipient(arg0: &FeeSettings) : address {
        arg0.recipient
    }

    public fun set_fee(arg0: &mut FeeSettings, arg1: 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::acl::AuthWitness, arg2: u64) {
        assert!(200000000 >= arg2, 9223372234423468036);
        arg0.amount = arg2;
    }

    public fun set_recipient(arg0: &mut FeeSettings, arg1: 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::acl::AuthWitness, arg2: address) {
        arg0.recipient = arg2;
    }

    // decompiled from Move bytecode v6
}

