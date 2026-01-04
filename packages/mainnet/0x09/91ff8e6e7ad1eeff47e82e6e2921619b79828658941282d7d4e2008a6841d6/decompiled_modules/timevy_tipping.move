module 0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::timevy_tipping {
    struct TimevyWithTip has copy, drop, store {
        tipper: address,
        owner: address,
        memory_db_id: vector<u8>,
        amount: u64,
    }

    public entry fun timevy_with_tip(arg0: 0x2::coin::Coin<0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::tvyn::TVYN>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 != arg2, 101);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::tvyn::TVYN>>(arg0, arg2);
        let v1 = TimevyWithTip{
            tipper       : v0,
            owner        : arg2,
            memory_db_id : arg1,
            amount       : 0x2::coin::value<0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::tvyn::TVYN>(&arg0),
        };
        0x2::event::emit<TimevyWithTip>(v1);
    }

    // decompiled from Move bytecode v6
}

