module 0x80781de2f0545395accef7724d26cd9ad19199e0630d20fcab45dfd4d9ee5b85::last_tard_remaining {
    struct LilTurd has store, key {
        id: 0x2::object::UID,
    }

    struct LastTardsStanding has key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        has_ended: bool,
        total_boinks: u64,
        last_tards: 0x2::linked_table::LinkedTable<u64, address>,
        booty: 0x2::balance::Balance<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>,
    }

    public fun boink(arg0: &mut LastTardsStanding, arg1: &mut 0x2::balance::Balance<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.start_time, 1);
        assert!(0x2::balance::value<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(arg1) >= 10000000000, 4);
        if ((0x2::clock::timestamp_ms(arg2) <= arg0.end_time || 0x2::linked_table::length<u64, address>(&arg0.last_tards) < 10) && !arg0.has_ended) {
            0x2::linked_table::push_front<u64, address>(&mut arg0.last_tards, arg0.total_boinks, 0x2::tx_context::sender(arg3));
            if (0x2::linked_table::length<u64, address>(&arg0.last_tards) > 10) {
                let (_, _) = 0x2::linked_table::pop_back<u64, address>(&mut arg0.last_tards);
            };
            if (0x2::linked_table::length<u64, address>(&arg0.last_tards) == 10) {
                arg0.end_time = 0x2::clock::timestamp_ms(arg2) + 30000;
            } else if (0x2::linked_table::length<u64, address>(&arg0.last_tards) > 10) {
                arg0.end_time = arg0.end_time + 30000;
            };
            arg0.total_boinks = arg0.total_boinks + 1;
            0x2::balance::join<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(&mut arg0.booty, 0x2::balance::split<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(arg1, 10000000000));
        } else if (0x2::clock::timestamp_ms(arg2) > arg0.end_time && 0x2::linked_table::length<u64, address>(&arg0.last_tards) == 10) {
            arg0.has_ended = true;
        };
    }

    public fun end_time(arg0: &LastTardsStanding) : u64 {
        arg0.end_time
    }

    public fun has_ended(arg0: &LastTardsStanding) : bool {
        arg0.has_ended
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LastTardsStanding{
            id           : 0x2::object::new(arg0),
            start_time   : 18446744073709551615,
            end_time     : 18446744073709551615,
            has_ended    : false,
            total_boinks : 0,
            last_tards   : 0x2::linked_table::new<u64, address>(arg0),
            booty        : 0x2::balance::zero<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(),
        };
        0x2::transfer::share_object<LastTardsStanding>(v0);
        let v1 = LilTurd{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LilTurd>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun settle(arg0: &LilTurd, arg1: &mut LastTardsStanding, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD> {
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.end_time && 0x2::linked_table::length<u64, address>(&arg1.last_tards) == 10, 0);
        arg1.has_ended = true;
        while (!0x2::linked_table::is_empty<u64, address>(&arg1.last_tards)) {
            let (_, v1) = 0x2::linked_table::pop_front<u64, address>(&mut arg1.last_tards);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>>(0x2::coin::from_balance<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(0x2::balance::split<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(&mut arg1.booty, 0x2::balance::value<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(&arg1.booty) * (10000 - 1000) / 10 * 10000), arg3), v1);
        };
        0x2::balance::split<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(&mut arg1.booty, 0x2::balance::value<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(&arg1.booty))
    }

    public fun start(arg0: &LilTurd, arg1: &mut LastTardsStanding, arg2: 0x2::balance::Balance<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>, arg3: u64) {
        0x2::balance::join<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(&mut arg1.booty, arg2);
        arg1.start_time = arg3;
        arg1.end_time = arg3 + 30000;
    }

    // decompiled from Move bytecode v6
}

