module 0x21259fb4242bf17e4418ec451e213d9622861e25422b19a9e68531ed2e35ee40::penny {
    struct PENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENNY>(arg0, 6, b"PENNY", b"PENNYWHALE", b"Dive into the exciting world of PennyWhale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pennywhale_87e7b2de68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

