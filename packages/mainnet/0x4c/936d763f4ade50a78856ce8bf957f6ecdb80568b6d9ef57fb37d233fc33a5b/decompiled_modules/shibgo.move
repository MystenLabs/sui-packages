module 0x4c936d763f4ade50a78856ce8bf957f6ecdb80568b6d9ef57fb37d233fc33a5b::shibgo {
    struct SHIBGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBGO>(arg0, 6, b"SHIBGO", b"Shiba GO", x"57656c636f6d6520746f205368696261474f0a746865207265766f6c7574696f6e617279206170702074686174207472616e73706f72747320796f7520746f20616e20656e746972656c79206e657720776f726c64206f662067616d696e672120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727292303500_b80e99780f023932221271e6bcc3b088_5376ccd7a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

