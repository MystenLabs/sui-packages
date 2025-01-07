module 0xd6ae5426a2e6a793227e8b6953f788f36023d4556224985dd4be3edce0b596cd::IDO {
    struct IDO has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        cap: u64,
        owner: address,
        whitelisted_addresses: vector<address>,
        funded_amount: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun create_ido(arg0: u64, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = IDO{
            id                    : 0x2::object::new(arg3),
            start_time            : arg0,
            end_time              : arg1,
            cap                   : 21000000,
            owner                 : v0,
            whitelisted_addresses : arg2,
            funded_amount         : 0,
            balance               : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<IDO>(v1, v0);
    }

    public entry fun fund_ido(arg0: &mut IDO, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_whitelisted(arg0, 0x2::tx_context::sender(arg3)), 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_time && v0 <= arg0.end_time, 2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg0.funded_amount + v1 <= arg0.cap, 3);
        arg0.funded_amount = arg0.funded_amount + v1;
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun is_whitelisted(arg0: &IDO, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public entry fun transfer_ido_funds(arg0: &mut IDO, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

