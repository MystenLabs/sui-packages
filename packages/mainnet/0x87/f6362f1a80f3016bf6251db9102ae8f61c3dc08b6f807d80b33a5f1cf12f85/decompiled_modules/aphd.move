module 0x87f6362f1a80f3016bf6251db9102ae8f61c3dc08b6f807d80b33a5f1cf12f85::aphd {
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

