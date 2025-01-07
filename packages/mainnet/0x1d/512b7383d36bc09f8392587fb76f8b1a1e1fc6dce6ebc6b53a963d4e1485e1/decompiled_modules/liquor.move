module 0x1d512b7383d36bc09f8392587fb76f8b1a1e1fc6dce6ebc6b53a963d4e1485e1::liquor {
    struct LIQUOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQUOR>(arg0, 6, b"Liquor", b"Be liquor on sui", b"Be liquor, my friend. New era of meme on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_H_E2_Fq_E_400x400_444d1edc8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQUOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQUOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

