module 0x93f6d0d9aa3de81e25377572f36175a8380d4b94b880e9b3aeae49242a2bcb9c::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"Suispicious", x"54686520535549207363656e65206973206b696e64612053554953207269676874206e6f772e2e20536f20627579205355495320746f206e6f7420626520535553210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/titel_b3f1f58ed0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

