module 0xfd6205125055c70e08b8228ba7793b10c61e0404f7aa34eaf0cf41465954bd0d::yj {
    struct YJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: YJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YJ>(arg0, 9, b"YJ", b"Yang Jian", b"The Chinese ancient immortal Yangjian in his modern life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6e6e13cbabce5624f5e253188d57aaafblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

