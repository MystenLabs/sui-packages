module 0xb7f16e3d3ec6788a2b8648bb0fbf94c779b1c77ba6ea5c1c3ed2e647782a79e1::catus {
    struct CATUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATUS>(arg0, 6, b"CATUS", b"Catusui", x"636174206c6f766573206361637475732c20737061726b7320666c65772c206e6f7720636174757320697320626f726e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250101_031723_135_fd850f97d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

