module 0x76ca5b5fc4dce3602de33d0bb8cf7139cdb2d1c1c273004feebf8b040dcacccf::monk {
    struct MONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONK>(arg0, 6, b"MONK", b"aaaMonk", b"Can't stop thinking on bananas aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_4_e5c639ae93.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

