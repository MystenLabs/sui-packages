module 0x3b5f53dd5cbd049f2041a8cad0498dc3a4a82cbde95edee9b7dcc871cb75cf63::assds {
    struct ASSDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSDS>(arg0, 6, b"Assds", b"nn", b"ded", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_04_04_at_19_02_12_ad28bf0db8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASSDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

