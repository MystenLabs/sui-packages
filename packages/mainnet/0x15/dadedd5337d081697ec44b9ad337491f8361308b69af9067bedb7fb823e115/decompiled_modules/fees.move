module 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::fees {
    struct Fees<phantom T0, phantom T1> has store {
        config: FeeConfig,
        fee_a: 0x2::balance::Balance<T0>,
        fee_b: 0x2::balance::Balance<T1>,
    }

    struct FeeConfig has copy, drop, store {
        fee_numerator: u64,
        fee_denominator: u64,
        min_fee: u64,
    }

    public fun balances<T0, T1>(arg0: &Fees<T0, T1>) : (&0x2::balance::Balance<T0>, &0x2::balance::Balance<T1>) {
        (&arg0.fee_a, &arg0.fee_b)
    }

    public(friend) fun balances_mut<T0, T1>(arg0: &mut Fees<T0, T1>) : (&mut 0x2::balance::Balance<T0>, &mut 0x2::balance::Balance<T1>) {
        (&mut arg0.fee_a, &mut arg0.fee_b)
    }

    public fun config<T0, T1>(arg0: &Fees<T0, T1>) : &FeeConfig {
        &arg0.config
    }

    public fun fee_a<T0, T1>(arg0: &Fees<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.fee_a
    }

    public fun fee_b<T0, T1>(arg0: &Fees<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.fee_b
    }

    public fun fee_denominator(arg0: &FeeConfig) : u64 {
        arg0.fee_denominator
    }

    public fun fee_numerator(arg0: &FeeConfig) : u64 {
        arg0.fee_numerator
    }

    public fun fee_ratio<T0, T1>(arg0: &Fees<T0, T1>) : (u64, u64) {
        (arg0.config.fee_numerator, arg0.config.fee_denominator)
    }

    public fun fee_ratio_(arg0: &FeeConfig) : (u64, u64) {
        (arg0.fee_numerator, arg0.fee_denominator)
    }

    public fun min_fee(arg0: &FeeConfig) : u64 {
        arg0.min_fee
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u64, arg2: u64) : Fees<T0, T1> {
        let v0 = FeeConfig{
            fee_numerator   : arg0,
            fee_denominator : arg1,
            min_fee         : arg2,
        };
        Fees<T0, T1>{
            config : v0,
            fee_a  : 0x2::balance::zero<T0>(),
            fee_b  : 0x2::balance::zero<T1>(),
        }
    }

    public(friend) fun new_config(arg0: u64, arg1: u64, arg2: u64) : FeeConfig {
        FeeConfig{
            fee_numerator   : arg0,
            fee_denominator : arg1,
            min_fee         : arg2,
        }
    }

    public(friend) fun set_config<T0, T1>(arg0: &mut Fees<T0, T1>, arg1: u64, arg2: u64, arg3: u64) {
        arg0.config = new_config(arg1, arg2, arg3);
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Fees<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::withdraw_all<T0>(&mut arg0.fee_a), 0x2::balance::withdraw_all<T1>(&mut arg0.fee_b))
    }

    // decompiled from Move bytecode v6
}

