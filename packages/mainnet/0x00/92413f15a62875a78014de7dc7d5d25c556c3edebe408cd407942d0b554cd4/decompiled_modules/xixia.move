module 0x92413f15a62875a78014de7dc7d5d25c556c3edebe408cd407942d0b554cd4::xixia {
    struct XIXIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIXIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIXIA>(arg0, 6, b"XIXIA", b"XIXIA SUI", b"The most powerful man from china always has his wif hat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_22_04_08_08_d1ba333fb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIXIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIXIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

