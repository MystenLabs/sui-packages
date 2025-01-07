module 0xf96ddd40238a4e29f13af6a4e01f74278178e37027e68c86059a08d3aade94ad::bzfx {
    struct BZFX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZFX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BZFX>(arg0, 6, b"BZFX", b"BLAZING FOX", b"Quick, clever, and burning with energy. Blazing Fox lights up the meme forest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_053558551_d6d1c0c92a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZFX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BZFX>>(v1);
    }

    // decompiled from Move bytecode v6
}

