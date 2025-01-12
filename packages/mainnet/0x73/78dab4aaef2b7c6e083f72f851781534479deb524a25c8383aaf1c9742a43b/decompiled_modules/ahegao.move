module 0x7378dab4aaef2b7c6e083f72f851781534479deb524a25c8383aaf1c9742a43b::ahegao {
    struct AHEGAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHEGAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHEGAO>(arg0, 6, b"AHEGAO", b"E-girl", x"456769726c73206a75737420696e76616465642053554920636f6d6520616e6420727562206f6e65206f7574206f722073686172652075722074686f75676874202f206c696e6b7320696e207468652067726f75700a496620796f7520617265206120312068616e64207479706572206c6567656e64206f6e6c7921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_713a68798c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHEGAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AHEGAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

