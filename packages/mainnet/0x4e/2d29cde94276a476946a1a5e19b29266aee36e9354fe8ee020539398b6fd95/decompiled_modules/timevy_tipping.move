module 0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::timevy_tipping {
    struct TimevyWithTip has copy, drop, store {
        tipper: address,
        owner: address,
        memory_db_id: vector<u8>,
        amount: u64,
    }

    public entry fun timevy_with_tip(arg0: 0x2::coin::Coin<0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::tvyn::TVYN>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 != arg2, 101);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::tvyn::TVYN>>(arg0, arg2);
        let v1 = TimevyWithTip{
            tipper       : v0,
            owner        : arg2,
            memory_db_id : arg1,
            amount       : 0x2::coin::value<0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::tvyn::TVYN>(&arg0),
        };
        0x2::event::emit<TimevyWithTip>(v1);
    }

    // decompiled from Move bytecode v6
}

