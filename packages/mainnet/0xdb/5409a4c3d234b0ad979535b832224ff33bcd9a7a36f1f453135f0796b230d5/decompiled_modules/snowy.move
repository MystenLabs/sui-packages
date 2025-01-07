module 0xdb5409a4c3d234b0ad979535b832224ff33bcd9a7a36f1f453135f0796b230d5::snowy {
    struct SNOWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWY>(arg0, 6, b"SNOWY", b"Snowy Sui", b"The cutest creature is arrive to Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p5_Nd_N_Ri_E_400x400_5fbf27f602.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

