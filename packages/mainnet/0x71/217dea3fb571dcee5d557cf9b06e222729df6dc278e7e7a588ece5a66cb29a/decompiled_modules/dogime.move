module 0x71217dea3fb571dcee5d557cf9b06e222729df6dc278e7e7a588ece5a66cb29a::dogime {
    struct DOGIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGIME>(arg0, 6, b"DOGIME", b"doginme_sui", b"$doginme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K8_X_Jxa8_U_400x400_ea11e5416e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

