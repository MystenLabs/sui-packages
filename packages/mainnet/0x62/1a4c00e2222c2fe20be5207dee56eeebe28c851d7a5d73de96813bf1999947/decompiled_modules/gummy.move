module 0x621a4c00e2222c2fe20be5207dee56eeebe28c851d7a5d73de96813bf1999947::gummy {
    struct GUMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMMY>(arg0, 9, b"GUMMY", b"GUMMY", x"2447554d4d5920697320343230206f6e20245355492026c2a0476f6d6d696573c2a04e4654c2a06279c2a0506561726c79", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmb2ga6AaQt8R7yu6mhaynjLt6sSB57ASemjfP2apgZukM/103.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GUMMY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMMY>>(v2, @0xfb0ea30edce005d8ca263aa879d43c7709ade0b2a7c6bd9a72ed4fcf197c2bac);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

