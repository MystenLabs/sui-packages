module 0xd1648a8b492df9fa54549d226648b769d22c178245b95fbb43aac49817ba99b0::six7 {
    struct SIX7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIX7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIX7>(arg0, 6, b"Six7", b"67", x"24363720e280932054686520756c74696d617465204368726973746d6173206d656d6520636f696e206f6e2053756920f09f8e84e29d84efb88f2057686572652053616e7461277320363725206e6175676874792c20333325206e6963652c20616e642031303025206d6f6f6e73686f742e20486f20686f20686f6c642120f09f9a80202336374368726973746d617320235375694d656d6522", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1766005908104.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIX7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIX7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

