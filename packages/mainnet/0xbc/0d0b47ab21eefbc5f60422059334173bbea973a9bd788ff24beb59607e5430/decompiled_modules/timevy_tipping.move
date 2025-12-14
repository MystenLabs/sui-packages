module 0xbc0d0b47ab21eefbc5f60422059334173bbea973a9bd788ff24beb59607e5430::timevy_tipping {
    struct TimevyWithTip has copy, drop, store {
        tipper: address,
        owner: address,
        memory_db_id: vector<u8>,
        amount: u64,
    }

    public entry fun timevy_with_tip(arg0: 0x2::coin::Coin<0xbc0d0b47ab21eefbc5f60422059334173bbea973a9bd788ff24beb59607e5430::tvyn::TVYN>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 != arg2, 101);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbc0d0b47ab21eefbc5f60422059334173bbea973a9bd788ff24beb59607e5430::tvyn::TVYN>>(arg0, arg2);
        let v1 = TimevyWithTip{
            tipper       : v0,
            owner        : arg2,
            memory_db_id : arg1,
            amount       : 0x2::coin::value<0xbc0d0b47ab21eefbc5f60422059334173bbea973a9bd788ff24beb59607e5430::tvyn::TVYN>(&arg0),
        };
        0x2::event::emit<TimevyWithTip>(v1);
    }

    // decompiled from Move bytecode v6
}

