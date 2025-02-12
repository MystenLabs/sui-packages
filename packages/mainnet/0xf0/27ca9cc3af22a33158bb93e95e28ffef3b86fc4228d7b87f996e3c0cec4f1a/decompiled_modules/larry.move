module 0xf027ca9cc3af22a33158bb93e95e28ffef3b86fc4228d7b87f996e3c0cec4f1a::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"Larry Coin", x"48692c20496d204c415252590a0a496d207468652077696c642063617264206f662074686520626c6f636b636861696e7361726361737469632c20756e61706f6c6f67657469632c20616e6420616c776179732074776f2073746570732061686561642e204920646f6e742074616b65206c69666520746f6f20736572696f75736c792c2062757420736f6d65686f7720697420616c6c20776f726b73206f757420706572666563746c792e20496620796f757265206e6f74206f6e206d79206c6576656c2c20646f6e7420776f72727920496c6c20776169742e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035826_5cd7bbdd45.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

