module 0x55ad7b98ec0fec162d52714f1b90f3124eb62f6e75c5a7106b3d8f98f34bc972::figgy {
    struct FIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGGY>(arg0, 6, b"FIGGY", b"Figgy the Fish Pig", b"Fish + Pig = $FIGGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/figgy_logo_0d9d7ee62b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

