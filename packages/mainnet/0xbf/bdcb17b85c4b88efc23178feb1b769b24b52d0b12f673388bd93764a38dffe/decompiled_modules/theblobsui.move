module 0xbfbdcb17b85c4b88efc23178feb1b769b24b52d0b12f673388bd93764a38dffe::theblobsui {
    struct THEBLOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEBLOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEBLOBSUI>(arg0, 6, b"THEBLOBSUI", b"Bob the Blob", b"My Name is Robert but you can call me Bob", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_220556386_58f2d1faf3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEBLOBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEBLOBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

