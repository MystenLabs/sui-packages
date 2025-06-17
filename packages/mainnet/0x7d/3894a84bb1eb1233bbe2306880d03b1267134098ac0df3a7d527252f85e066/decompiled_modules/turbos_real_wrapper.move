module 0x7d3894a84bb1eb1233bbe2306880d03b1267134098ac0df3a7d527252f85e066::turbos_real_wrapper {
    struct TurbosRealPTBExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        timestamp: u64,
        method: vector<u8>,
        success: bool,
        turbos_package: address,
        versioned_object: address,
        pool_id: address,
    }

    public fun get_cli_pattern() : vector<u8> {
        b"sui client ptb --split-coins gas [amount] --make-move-vec <Coin<SUI>> [coin] --move-call package::swap_router::swap_a_b pool vector amount min_out price_limit true recipient deadline clock versioned"
    }

    public fun get_pool_id() : address {
        @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78
    }

    public fun get_turbos_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_versioned_object() : address {
        @0xf1cf0e81048df168ebeb1b8030fad24b3e0b53ae827c25053fff0779c1445b6f
    }

    public entry fun ptb_turbos_swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 5001);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = TurbosRealPTBExecuted{
            sender           : v1,
            amount_in        : v0,
            min_amount_out   : arg1,
            timestamp        : 0x2::clock::timestamp_ms(arg2),
            method           : b"ptb_turbos_swap_a_b_real_integration",
            success          : true,
            turbos_package   : @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1,
            versioned_object : @0xf1cf0e81048df168ebeb1b8030fad24b3e0b53ae827c25053fff0779c1445b6f,
            pool_id          : @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78,
        };
        0x2::event::emit<TurbosRealPTBExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

