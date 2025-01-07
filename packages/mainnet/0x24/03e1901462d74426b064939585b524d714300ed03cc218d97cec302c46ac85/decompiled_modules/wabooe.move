module 0x2403e1901462d74426b064939585b524d714300ed03cc218d97cec302c46ac85::wabooe {
    struct WABOOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WABOOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WABOOE>(arg0, 6, b"Wabooe", b"Pochita's Twin Brother", b"Pochita's Twin Brother ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241003_104106_858_0778ca7759.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WABOOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WABOOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

