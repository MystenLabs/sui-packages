module 0x8ac626e9dd17cab51a13cd560e9e0f3c03071471236b503160f5cd9c08ae4184::suitama {
    struct SUITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 6, b"SUITAMA", b"SuitamaOnSui", b"Meme coin on sui comunity grow up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_234006_bf71ea006b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

