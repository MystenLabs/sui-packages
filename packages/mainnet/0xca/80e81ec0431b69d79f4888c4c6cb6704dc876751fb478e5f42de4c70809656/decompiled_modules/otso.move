module 0xca80e81ec0431b69d79f4888c4c6cb6704dc876751fb478e5f42de4c70809656::otso {
    struct OTSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTSO>(arg0, 6, b"Otso", b"Otso Bear", b"Bear sucks his paw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_10_09_D_12_16_01_053a27a3c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

