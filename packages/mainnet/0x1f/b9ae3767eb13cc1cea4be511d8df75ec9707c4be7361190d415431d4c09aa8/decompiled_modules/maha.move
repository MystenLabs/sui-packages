module 0x1fb9ae3767eb13cc1cea4be511d8df75ec9707c4be7361190d415431d4c09aa8::maha {
    struct MAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAHA>(arg0, 6, b"MAHA", b"MAHA OG", b"Make America Healthy Again! $MAHA with DJT and RFK Jr.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241117_002951_495_f7582a1e1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

