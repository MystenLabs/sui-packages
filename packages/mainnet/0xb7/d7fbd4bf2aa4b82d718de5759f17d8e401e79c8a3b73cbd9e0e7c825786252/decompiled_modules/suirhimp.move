module 0xb7d7fbd4bf2aa4b82d718de5759f17d8e401e79c8a3b73cbd9e0e7c825786252::suirhimp {
    struct SUIRHIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRHIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRHIMP>(arg0, 6, b"SUIRHIMP", b"suirhimp", b"lets get this sui shrimp to a sui whale.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirhimp_8405abe7fa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRHIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRHIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

