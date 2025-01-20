module 0x8b955b3dd163b51bb8fda1101aaf2b942a320e97bd87342de576bb491f272865::acn {
    struct ACN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACN>(arg0, 9, b"acn", b"AuraCoin", b"Aura Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ACN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACN>>(v2, @0x24bfb604c9801e45bf76b3f4b56d48f06e30e15788b512ac018e07138cb4c469);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACN>>(v1);
    }

    // decompiled from Move bytecode v6
}

