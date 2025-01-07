module 0x95c8162223c2041788d27d403d782865ecf672307c62839bbc9b2b757b8ecc87::sfx {
    struct SFX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFX>(arg0, 6, b"SFX", b"Suuflex", b"not just another streaming platfrom. we make moves we make waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0955_321e944c89.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFX>>(v1);
    }

    // decompiled from Move bytecode v6
}

