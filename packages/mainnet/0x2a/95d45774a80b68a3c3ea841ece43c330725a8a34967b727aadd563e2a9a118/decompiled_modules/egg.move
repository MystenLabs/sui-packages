module 0x2a95d45774a80b68a3c3ea841ece43c330725a8a34967b727aadd563e2a9a118::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 9, b"EGG", b"EGGDENIYI", x"2445474720697320612066756e206d656d65636f696e207468617420697320696e737069726564206279204567672041667465726d617468204e4654202b204164656e69796927732042616c6420486561642e204e6f20486169722e204e6f204c696d6974732e204a757374207075726520437261636b656420456e657267792e204c657427732073656e6420244547472068696768657220f09f9a80f09fa59af09fa59af09fa59a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/1df8cf3eff3681ea0bed73df91b04f466e49ed9466967b911ce5b9f65cca4323")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<EGG>>(0x2::coin::mint<EGG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

