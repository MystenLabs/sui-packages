module 0x8718459ac52121b3044dd871a78355abe3265d591449b1e91a71cbbb885e674e::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"SUITOSHI", b"Foundoooor of Bitcoin - SUITOSHI (SUI)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cnk_Xq5n_400x400_copy_9167b255fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

