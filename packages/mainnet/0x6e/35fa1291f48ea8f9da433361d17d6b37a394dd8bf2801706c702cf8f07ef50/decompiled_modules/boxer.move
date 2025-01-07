module 0x6e35fa1291f48ea8f9da433361d17d6b37a394dd8bf2801706c702cf8f07ef50::boxer {
    struct BOXER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOXER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOXER>(arg0, 6, b"Boxer", b"SUIBoxer", b"SUI said f*** off, but we say welcome", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boxer_9013f4ee2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOXER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOXER>>(v1);
    }

    // decompiled from Move bytecode v6
}

