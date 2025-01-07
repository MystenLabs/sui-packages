module 0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::fee_module {
    struct FeeNumeratorEvent has copy, drop {
        create_flat_fee: u64,
        create_fee_numerator: u64,
        claim_fee_numerator: u64,
    }

    struct Fee has key {
        id: 0x2::object::UID,
        create_flat_fee: u64,
        create_fee_numerator: u64,
        claim_fee_numerator: u64,
    }

    public fun claim_fee(arg0: &Fee, arg1: u64) : u64 {
        mul_div(arg1, arg0.claim_fee_numerator, 10000)
    }

    public fun fee_denominator() : u64 {
        10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Fee{
            id                   : 0x2::object::new(arg0),
            create_flat_fee      : 100000000,
            create_fee_numerator : 50,
            claim_fee_numerator  : 25,
        };
        0x2::transfer::share_object<Fee>(v0);
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public entry fun set_claim_fee(arg0: &0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::role::Role, arg1: &mut Fee, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::role::only_admin(arg0, arg3);
        assert!(arg2 <= 1000, 1);
        arg1.claim_fee_numerator = arg2;
        let v0 = FeeNumeratorEvent{
            create_flat_fee      : arg1.create_flat_fee,
            create_fee_numerator : arg1.create_fee_numerator,
            claim_fee_numerator  : arg2,
        };
        0x2::event::emit<FeeNumeratorEvent>(v0);
    }

    public entry fun set_streaming_fee(arg0: &0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::role::Role, arg1: &mut Fee, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::role::only_admin(arg0, arg3);
        assert!(arg2 <= 1000, 1);
        arg1.create_fee_numerator = arg2;
        let v0 = FeeNumeratorEvent{
            create_flat_fee      : arg1.create_flat_fee,
            create_fee_numerator : arg2,
            claim_fee_numerator  : arg1.claim_fee_numerator,
        };
        0x2::event::emit<FeeNumeratorEvent>(v0);
    }

    public entry fun set_streaming_flat_fee(arg0: &0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::role::Role, arg1: &mut Fee, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::role::only_admin(arg0, arg3);
        arg1.create_flat_fee = arg2;
        let v0 = FeeNumeratorEvent{
            create_flat_fee      : arg2,
            create_fee_numerator : arg1.create_fee_numerator,
            claim_fee_numerator  : arg1.claim_fee_numerator,
        };
        0x2::event::emit<FeeNumeratorEvent>(v0);
    }

    public fun streaming_fee(arg0: &Fee, arg1: u64) : u64 {
        mul_div(arg1, arg0.create_fee_numerator, 10000)
    }

    public fun streaming_flat_fee(arg0: &Fee) : u64 {
        arg0.create_flat_fee
    }

    // decompiled from Move bytecode v6
}

