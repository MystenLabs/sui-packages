module 0x20e2efc2f475be3527f0b9934154a9f026a016309ebfff2c27ee34d02170444d::suicred {
    struct SuiCredBadge has store, key {
        id: 0x2::object::UID,
        score: u64,
        tier: vector<u8>,
    }

    public entry fun mint_score(arg0: u64, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 1000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0xce5c72750ddcbfbead5c3690c580a7835eab6dacfef98f36cb167fc9f351e87f);
        let v0 = SuiCredBadge{
            id    : 0x2::object::new(arg3),
            score : arg0,
            tier  : arg1,
        };
        0x2::transfer::transfer<SuiCredBadge>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

