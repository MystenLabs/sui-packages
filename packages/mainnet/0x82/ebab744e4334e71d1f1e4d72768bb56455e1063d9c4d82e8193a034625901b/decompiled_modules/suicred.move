module 0x82ebab744e4334e71d1f1e4d72768bb56455e1063d9c4d82e8193a034625901b::suicred {
    struct SuiCredBadge has store, key {
        id: 0x2::object::UID,
        score: u64,
        tier: vector<u8>,
        name: vector<u8>,
        description: vector<u8>,
        image_url: vector<u8>,
    }

    public entry fun mint_score(arg0: u64, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 10000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0xce5c72750ddcbfbead5c3690c580a7835eab6dacfef98f36cb167fc9f351e87f);
        let v0 = SuiCredBadge{
            id          : 0x2::object::new(arg3),
            score       : arg0,
            tier        : tier_for_score(arg0),
            name        : b"SuiCred Score Card",
            description : b"SuiCred on-chain reputation card.",
            image_url   : arg1,
        };
        0x2::transfer::transfer<SuiCredBadge>(v0, 0x2::tx_context::sender(arg3));
    }

    fun tier_for_score(arg0: u64) : vector<u8> {
        if (arg0 >= 500) {
            b"Sui"
        } else if (arg0 >= 350) {
            b"Diamond"
        } else if (arg0 >= 300) {
            b"Gold"
        } else if (arg0 >= 200) {
            b"Silver"
        } else {
            b"Bronze"
        }
    }

    // decompiled from Move bytecode v6
}

