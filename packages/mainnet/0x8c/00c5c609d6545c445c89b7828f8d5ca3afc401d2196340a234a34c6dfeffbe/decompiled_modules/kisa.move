module 0x8c00c5c609d6545c445c89b7828f8d5ca3afc401d2196340a234a34c6dfeffbe::kisa {
    struct KISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISA>(arg0, 6, b"Kisa", b"kisa on Sui", b"CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Afpn_AGNM_400x400_03f4d9dfcc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

