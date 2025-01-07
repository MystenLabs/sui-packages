module 0x4adefca6c68f0784c88824061dd082b2f585b30adf2aa7ba37bf3a02d34d9a0f::gj {
    struct GJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GJ>(arg0, 9, b"GJ", b"Good Job", b"Nice Job", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b2a7a01-b447-452b-9e7e-40c1cd2dec99.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

