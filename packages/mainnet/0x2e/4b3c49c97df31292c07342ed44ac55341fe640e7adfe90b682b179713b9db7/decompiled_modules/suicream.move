module 0x2e4b3c49c97df31292c07342ed44ac55341fe640e7adfe90b682b179713b9db7::suicream {
    struct SUICREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICREAM>(arg0, 6, b"SUICREAM", b"The Suicream", x"54686520537569637265616d206973206f6e65206f66205375696e696368206d6f73742066616d6f7573207061696e74696e672e0a0a497420726570726573656e747320616e53554969657479206f662061206261627920686970706f20206120636f6d6d6f6e20616e696d616c20636f6e646974696f6e2c207768696368207468656e2077656e74206f6e20746f20696e666c75656e636520746865205a6f6f6e697374206d6f76656d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6071304437948858448_y_4d19598f0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

