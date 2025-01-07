module 0x8360f12239cd514be67e2bcdd823165591555d7db586565f96b2f5b66d14cf07::jellyai {
    struct JELLYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYAI>(arg0, 6, b"JellyAI", b"World War Jelly", b"JellyAl's mission is to provide you with a better future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957181309.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELLYAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

