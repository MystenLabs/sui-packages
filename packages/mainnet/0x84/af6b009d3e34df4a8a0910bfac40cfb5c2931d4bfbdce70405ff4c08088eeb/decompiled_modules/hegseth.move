module 0x84af6b009d3e34df4a8a0910bfac40cfb5c2931d4bfbdce70405ff4c08088eeb::hegseth {
    struct HEGSETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEGSETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEGSETH>(arg0, 9, b"hegseth", b"hegsteh", b"usa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HEGSETH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEGSETH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEGSETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

