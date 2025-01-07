module 0x4122300765eec0b8e4b81ae166e362cab74d5adea24f9ae1caf35ca5c1092700::suimo {
    struct SUIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMO>(arg0, 6, b"SUIMO", b"SUIMO TOKEN", x"245375696d6f2069732061206d656d6520746f6b656e206261736564206f6e205375692d4e6574776f726b2c20696e7370697265642062792053756d6f206973204a6170616e657365207374796c65206f662077726573746c696e6720616e640a4a6170616e2773206e6174696f6e616c2073706f7274", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimo_9691bf301d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

