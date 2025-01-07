module 0xe8d3650894e746e3fd5925338c982fd2465ab4d3e6b29269a490234329bcd21a::xpup {
    struct XPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPUP>(arg0, 6, b"Xpup", b"Xmas Pup", x"536e6f77206d61792066616c6c2c20627574206d7920666c7566667920667269656e64206d616b6573206d79206865617274207761726d20616c6c20736561736f6e206c6f6e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ccc_5ef420d9d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

