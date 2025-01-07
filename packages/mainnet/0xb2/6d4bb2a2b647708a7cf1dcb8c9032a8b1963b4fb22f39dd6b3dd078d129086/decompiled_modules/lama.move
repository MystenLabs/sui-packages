module 0xb26d4bb2a2b647708a7cf1dcb8c9032a8b1963b4fb22f39dd6b3dd078d129086::lama {
    struct LAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMA>(arg0, 6, b"LAMA", b"llama", b"Lama glama", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lama_Dlama_b2f984fdee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

