module 0x1e1dfd335992459758d372c309c35c9dd611f9e50d9fe0058161c289778ae7d::hbibi {
    struct HBIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBIBI>(arg0, 6, b"HBIBI", b"HABIBI", x"4841424942492c20544849532041494e2754204a555354204120434f494e2c20495427532041204c4946455354494c45200a57454c434f4d4520544f20535549204841424942492021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihhxb5vfm6sp3bian2k47tudn45pwbcy74keh725xhonbeoczd3xy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HBIBI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

