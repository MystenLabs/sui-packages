module 0x758971bfc5c5322d187f8fc3a01b92d59ec164388aeae02daedd2dac282342af::yangtze {
    struct YANGTZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YANGTZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YANGTZE>(arg0, 6, b"Yangtze", b"The smiling Dolphin", b"Yangtze finless porpoise looks like its giving a tired, strained smile that might be given out of politeness, social discomfort, or even a kind of exhausted pity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0712_4f187ed653.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YANGTZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YANGTZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

