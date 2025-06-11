module 0x83aaa17b44ddc64cbb4d4571e08846fbccd8c8b5b52b153c42b9b1620612725f::avtd {
    struct AVTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVTD>(arg0, 6, b"AVTD", b"Avatard", b"AVATARd tak over arlidy begun SUI is sluwly gettung invadud by avatards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiabsvsdlefnizuo3zx2gfbe5x4iumexmwoqpzbp2uj6avnauaznny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AVTD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

