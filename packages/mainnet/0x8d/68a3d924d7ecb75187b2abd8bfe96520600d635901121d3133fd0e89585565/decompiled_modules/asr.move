module 0x8d68a3d924d7ecb75187b2abd8bfe96520600d635901121d3133fd0e89585565::asr {
    struct ASR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASR>(arg0, 6, b"ASR", b"Arnold Suizenegger", b"1st Hollywood meme!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_21_22_43_04_d302d9016b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASR>>(v1);
    }

    // decompiled from Move bytecode v6
}

