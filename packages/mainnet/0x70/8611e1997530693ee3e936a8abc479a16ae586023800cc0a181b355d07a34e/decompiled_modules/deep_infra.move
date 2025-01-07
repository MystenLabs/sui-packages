module 0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::deep_infra {
    struct DeepSponsor has key {
        id: 0x2::object::UID,
        deep_balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        total_sponsorship: u64,
    }

    public(friend) fun get_sponsored_deep(arg0: &mut DeepSponsor, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_balance, arg1), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepSponsor{
            id                : 0x2::object::new(arg0),
            deep_balance      : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            total_sponsorship : 0,
        };
        0x2::transfer::share_object<DeepSponsor>(v0);
    }

    public fun topup_deep(arg0: &0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::admin::AdminCap, arg1: &mut DeepSponsor, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        arg1.total_sponsorship = arg1.total_sponsorship + 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg2);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.deep_balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2));
    }

    public fun withdraw_sponsored_deep(arg0: &0x40f589c559a69f7cf73bb22a7e4a501dfbaaa2e75bbdd982b73fce9584adc362::admin::AdminCap, arg1: &mut DeepSponsor, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.deep_balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

