module 0x38ce49e2f293bcc5f69964e7986cdb5d0dd0dbf6796a70784edb8e029463e31::bsuiman {
    struct BSUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUIMAN>(arg0, 6, b"BSUIMAN", b"BabySUIMAN", b"$bsuiman is a meme baby token on the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_B_Gi04_8_400x400_1_7259a073cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

