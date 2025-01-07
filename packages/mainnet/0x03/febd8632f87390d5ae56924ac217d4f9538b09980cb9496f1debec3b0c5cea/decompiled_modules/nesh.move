module 0x3febd8632f87390d5ae56924ac217d4f9538b09980cb9496f1debec3b0c5cea::nesh {
    struct NESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NESH>(arg0, 6, b"NESH", b"Nesh AI", b"All-in-one #AI platform: easy access to top models and blockchain-based API integration for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BXF_Ry7_Pu_400x400_5a46620ae2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

