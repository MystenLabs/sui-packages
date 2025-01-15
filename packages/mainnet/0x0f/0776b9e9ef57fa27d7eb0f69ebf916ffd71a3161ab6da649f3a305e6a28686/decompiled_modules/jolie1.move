module 0xf0776b9e9ef57fa27d7eb0f69ebf916ffd71a3161ab6da649f3a305e6a28686::jolie1 {
    struct JOLIE1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLIE1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOLIE1>(arg0, 6, b"JOLIE1", b"Jolie me", b"Hi. It's me, Jolie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/World_s_Most_Instagrammed_Beaches_23ea31fed3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLIE1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOLIE1>>(v1);
    }

    // decompiled from Move bytecode v6
}

