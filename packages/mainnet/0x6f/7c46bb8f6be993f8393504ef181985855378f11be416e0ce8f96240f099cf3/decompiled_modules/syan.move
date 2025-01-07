module 0x6f7c46bb8f6be993f8393504ef181985855378f11be416e0ce8f96240f099cf3::syan {
    struct SYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYAN>(arg0, 6, b"SYAN", b"SYAN CAT", b"You guys are top tier degenerates, thats why this exists", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagen_2024_10_22_184954221_594478dee8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

