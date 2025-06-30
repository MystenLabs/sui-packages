module 0x699aba0b12fe8aafffdd452983ad91371a92a28c51ceb80f7bab32293a376dc6::aphd {
    struct APHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: APHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APHD>(arg0, 6, b"APHD", b"Applehead", b"Applehead is a revolutionary token creating real-world impact, empowering you to make your own path.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicgbwrzornomqq7mmfmhzwhgma7xuvofwdfjidmitrupglnnvifjy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APHD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

