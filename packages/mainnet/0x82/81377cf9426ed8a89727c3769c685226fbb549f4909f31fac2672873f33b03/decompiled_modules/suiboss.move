module 0x8281377cf9426ed8a89727c3769c685226fbb549f4909f31fac2672873f33b03::suiboss {
    struct SUIBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOSS>(arg0, 6, b"SUIBOSS", b"Suibiza Final Boss", b"'I thought it was a hat!' Video of man with bob throwing shapes in Suibiza sparks hilarious memes. Now on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia3qcfzitsql477burryu2c6lyvcf7tjhshvexcrihkcojc43uyjm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBOSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

