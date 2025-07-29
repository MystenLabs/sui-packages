module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate {
    struct HistoricRate has store, key {
        id: 0x2::object::UID,
        exchange_rate: 0x2::table::Table<u32, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate>,
        initial_epoch: u32,
    }

    public(friend) fun borrow(arg0: &HistoricRate, arg1: u32) : &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate {
        0x2::table::borrow<u32, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate>(&arg0.exchange_rate, arg1)
    }

    public(friend) fun borrow_mut(arg0: &mut HistoricRate, arg1: u32) : &mut 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate {
        0x2::table::borrow_mut<u32, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate>(&mut arg0.exchange_rate, arg1)
    }

    public(friend) fun new(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : HistoricRate {
        let v0 = 0x2::table::new<u32, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate>(arg1);
        0x2::table::add<u32, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate>(&mut v0, arg0, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::empty());
        HistoricRate{
            id            : 0x2::object::new(arg1),
            exchange_rate : v0,
            initial_epoch : arg0,
        }
    }

    public(friend) fun contains(arg0: &HistoricRate, arg1: u32) : bool {
        0x2::table::contains<u32, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate>(&arg0.exchange_rate, arg1)
    }

    public(friend) fun add_epoch(arg0: &mut HistoricRate, arg1: u32, arg2: u64, arg3: u64) {
        0x2::table::add<u32, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate>(&mut arg0.exchange_rate, arg1, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::new(arg2, arg3));
    }

    public(friend) fun rate_at_epoch(arg0: &HistoricRate, arg1: u32) : 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate {
        while (arg1 >= arg0.initial_epoch) {
            if (0x2::table::contains<u32, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate>(&arg0.exchange_rate, arg1)) {
                return *0x2::table::borrow<u32, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::ExchangeRate>(&arg0.exchange_rate, arg1)
            };
            arg1 = arg1 - 1;
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::empty()
    }

    // decompiled from Move bytecode v6
}

