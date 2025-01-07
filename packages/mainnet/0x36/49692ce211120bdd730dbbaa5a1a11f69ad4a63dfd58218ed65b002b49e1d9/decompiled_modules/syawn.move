module 0x3649692ce211120bdd730dbbaa5a1a11f69ad4a63dfd58218ed65b002b49e1d9::syawn {
    struct SYAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYAWN>(arg0, 6, b"SYAWN", b"Syawn", b"ZzzzZzzz ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yawnm_6b26ecc745.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

