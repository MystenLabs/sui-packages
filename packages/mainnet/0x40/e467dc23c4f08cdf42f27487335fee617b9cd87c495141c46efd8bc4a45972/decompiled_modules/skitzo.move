module 0x40e467dc23c4f08cdf42f27487335fee617b9cd87c495141c46efd8bc4a45972::skitzo {
    struct SKITZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITZO>(arg0, 6, b"SKITZO", b"SKITZOFRENIC", b"I hear voices please be patient ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5342_8c8850f592.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKITZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

