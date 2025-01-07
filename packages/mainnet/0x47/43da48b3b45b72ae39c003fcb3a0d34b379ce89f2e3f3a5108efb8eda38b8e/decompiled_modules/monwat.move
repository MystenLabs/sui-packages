module 0x4743da48b3b45b72ae39c003fcb3a0d34b379ce89f2e3f3a5108efb8eda38b8e::monwat {
    struct MONWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONWAT>(arg0, 6, b"MONWAT", b"Monkey in water", b"Its like Bitcoin but with more bananas and less stress!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_154752_24521bc6d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONWAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONWAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

