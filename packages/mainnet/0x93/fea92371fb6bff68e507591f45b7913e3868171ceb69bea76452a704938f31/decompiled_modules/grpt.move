module 0x93fea92371fb6bff68e507591f45b7913e3868171ceb69bea76452a704938f31::grpt {
    struct GRPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRPT>(arg0, 6, b"GRPT", b"GRUMPY PARROT", b"Squawking its way to the top. Grumpy Parrot has no chill but plenty of gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_043459695_df45e8d28d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

