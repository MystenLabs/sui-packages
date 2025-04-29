module 0xf1ce78b9f60e0419cfb7884caa43eb4c5b4d417490b9bafa0a9ef82465833bbf::newwww1 {
    struct NEWWWW1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWWWW1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWWWW1>(arg0, 9, b"Newwww1", b"Newwww", b"Newwww Newwww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9e516d059bb588a608e6544215dd30deblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWWWW1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWWWW1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

