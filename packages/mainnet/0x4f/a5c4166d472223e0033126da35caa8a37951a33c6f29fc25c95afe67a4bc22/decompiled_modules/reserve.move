module 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve {
    struct PayFeeEvent has copy, drop {
        payer: address,
        fee: u64,
    }

    struct ReserveAdmin has store, key {
        id: 0x2::object::UID,
    }

    struct Reserve<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        coin_reserve: 0x2::object_table::ObjectTable<address, 0x2::coin::Coin<0x2::sui::SUI>>,
        vested_token_reserve: 0x2::object_table::ObjectTable<address, T0>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_rate: u64,
    }

    public(friend) fun add_coin_to_reserve<T0: store + key>(arg0: &mut Reserve<T0>, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::object_table::add<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.coin_reserve, arg1, arg2);
    }

    public(friend) fun add_vested_token_to_reserve_and_pay_fee<T0: store + key>(arg0: &mut Reserve<T0>, arg1: address, arg2: T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::object_table::add<address, T0>(&mut arg0.vested_token_reserve, arg1, arg2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3) * arg0.fee_rate / 1000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg4)));
        let v1 = PayFeeEvent{
            payer : 0x2::tx_context::sender(arg4),
            fee   : v0,
        };
        0x2::event::emit<PayFeeEvent>(v1);
        arg3
    }

    public fun assert_order_exist<T0: store + key>(arg0: &Reserve<T0>, arg1: address) {
        assert!(!0x2::object_table::contains<address, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.coin_reserve, arg1) && !0x2::object_table::contains<address, T0>(&arg0.vested_token_reserve, arg1), 0);
    }

    public entry fun collect_fee<T0: store + key>(arg0: &ReserveAdmin, arg1: &mut Reserve<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.fee, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_reserve<T0: store + key>(arg0: &ReserveAdmin, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserve<T0>{
            id                   : 0x2::object::new(arg2),
            coin_reserve         : 0x2::object_table::new<address, 0x2::coin::Coin<0x2::sui::SUI>>(arg2),
            vested_token_reserve : 0x2::object_table::new<address, T0>(arg2),
            fee                  : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_rate             : arg1,
        };
        0x2::transfer::public_share_object<Reserve<T0>>(v0);
    }

    public(friend) fun get_coin_from_reserve_and_pay_fee<T0: store + key>(arg0: &mut Reserve<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::object_table::remove<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.coin_reserve, arg1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0) * arg0.fee_rate / 1000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1, arg2)));
        let v2 = PayFeeEvent{
            payer : 0x2::tx_context::sender(arg2),
            fee   : v1,
        };
        0x2::event::emit<PayFeeEvent>(v2);
        v0
    }

    public(friend) fun get_vested_token_from_reserve<T0: store + key>(arg0: &mut Reserve<T0>, arg1: address) : T0 {
        0x2::object_table::remove<address, T0>(&mut arg0.vested_token_reserve, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReserveAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ReserveAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

