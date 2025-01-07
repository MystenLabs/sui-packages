module 0x6b450b2ec7255095ec242d835ae921c178e35e796a4a9fb903944f6c05ad60d0::taotao {
    struct TAOTAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOTAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOTAO>(arg0, 6, b"TaoTao", b"hanbao is the son", b"Hanbao is the son of a female porpoise named Tao Tao. She was the first finless porpoise born through artificial breeding.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_080a632356.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOTAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOTAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

