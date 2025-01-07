module 0x5ec11c087e1f4f566e0ac6d29f1c4eb39113f72bc9d8aa736abd145ab146ab32::w {
    struct W has drop {
        dummy_field: bool,
    }

    fun init(arg0: W, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W>(arg0, 6, b"W", b"wises", b"A meme adaptation of the Ethereum network where all supply is owned by the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/be7ae60c_4d2b_46c9_90eb_37c3b8558026_cebb7bb953.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<W>>(v1);
    }

    // decompiled from Move bytecode v6
}

