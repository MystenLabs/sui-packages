module 0x249c95f3922329c3428acbe667dbe2acad1b3d8a3b632a711ba5f73dbcb07c16::frent {
    struct FRENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENT>(arg0, 6, b"FRENT", b"FRENT.AI", b"Creating an interactive socialfi AI agents users can own and nature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031873_b06ce88d35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

