module 0x44e03299cc85598200282e48ad54e4555d33d5165b45bff7d9e0748079a3e2c4::sfx {
    struct SFX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFX>(arg0, 6, b"SFX", b"Suuflex", b"Simply flexing in sui ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240923_195816_393_a11091e058.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFX>>(v1);
    }

    // decompiled from Move bytecode v6
}

