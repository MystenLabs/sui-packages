module 0x7c6d5cc4874cfe3fb7ca200c058fa44b52ef2a6c03a4d9dc3779b4bf789490e8::saly {
    struct SALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALY>(arg0, 6, b"SALY", b"Sui allday", b"Sui allday TOKEN MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_e5fbaf0206.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

