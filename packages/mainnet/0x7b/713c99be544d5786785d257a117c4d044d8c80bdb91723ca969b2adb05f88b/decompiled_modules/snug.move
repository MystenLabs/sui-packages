module 0x7b713c99be544d5786785d257a117c4d044d8c80bdb91723ca969b2adb05f88b::snug {
    struct SNUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUG>(arg0, 9, b"SNUG", b"SnuggleCle", b"Discover the world of SnuggleCleo, where crypto enthusiasts and cat lovers unite. Embrace the warmth and companionship Cleo brings to the blockchain community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e47fe4cb-0fae-4331-9138-fb5b3b3d4aa2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

