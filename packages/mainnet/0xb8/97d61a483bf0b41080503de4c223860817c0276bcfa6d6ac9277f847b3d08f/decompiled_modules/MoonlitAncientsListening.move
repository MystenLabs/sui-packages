module 0xb897d61a483bf0b41080503de4c223860817c0276bcfa6d6ac9277f847b3d08f::MoonlitAncientsListening {
    struct MOONLITANCIENTSLISTENING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONLITANCIENTSLISTENING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONLITANCIENTSLISTENING>(arg0, 0, b"COS", b"Moonlit Ancient's Listening", b"At moonset, these whispers will be forgotten...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Moonlit_Ancients_Listening.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONLITANCIENTSLISTENING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONLITANCIENTSLISTENING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

