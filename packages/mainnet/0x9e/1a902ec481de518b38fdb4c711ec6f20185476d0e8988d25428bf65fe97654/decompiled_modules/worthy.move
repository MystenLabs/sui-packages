module 0x9e1a902ec481de518b38fdb4c711ec6f20185476d0e8988d25428bf65fe97654::worthy {
    struct WORTHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORTHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORTHY>(arg0, 9, b"WORTHY", b"Proof Of Sui", b"Proof of SUI (WORTHY) is a utility token on the Sui blockchain, used for staking, paying transaction fees (gas), and participating in network governance. It supports decentralization, rewards users who delegate tokens to validators, and strengthens the security of the network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1749264455769440256/lJotPP7_.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WORTHY>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORTHY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORTHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

