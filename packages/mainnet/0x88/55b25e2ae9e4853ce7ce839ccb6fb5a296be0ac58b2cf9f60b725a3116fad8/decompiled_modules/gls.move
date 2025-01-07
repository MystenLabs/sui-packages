module 0x8855b25e2ae9e4853ce7ce839ccb6fb5a296be0ac58b2cf9f60b725a3116fad8::gls {
    struct GLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLS>(arg0, 9, b"GLS", b"glass", x"616e6f74686572206f6e652061626f757420676c617373636f696e0a5368696e652062726967687420f09f988ef09f988e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72e38c2b-00d5-4e0a-a7ff-dc433053ecc7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

