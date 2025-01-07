module 0xd338a7dcb0e57039676e59e8a01e5c1ae5669ced18faed73fa0f233de8eedb00::aparkadia {
    struct APARKADIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: APARKADIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APARKADIA>(arg0, 6, b"APARKADIA", b"Sparkadia", b"Find your SPARK as you create, collect, and claim your place in this optimistic world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q5_Cm_ZMAN_400x400_47ab071138.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APARKADIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APARKADIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

