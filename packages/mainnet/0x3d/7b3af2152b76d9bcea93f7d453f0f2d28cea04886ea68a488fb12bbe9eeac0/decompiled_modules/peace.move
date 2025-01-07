module 0x3d7b3af2152b76d9bcea93f7d453f0f2d28cea04886ea68a488fb12bbe9eeac0::peace {
    struct PEACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACE>(arg0, 6, b"PEACE", b"World Peace", b"Hope the world is peaceful and there are no more wars! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241005052712_a5ae8323b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

