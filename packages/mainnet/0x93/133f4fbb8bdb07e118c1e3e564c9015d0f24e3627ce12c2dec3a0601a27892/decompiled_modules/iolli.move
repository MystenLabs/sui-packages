module 0x93133f4fbb8bdb07e118c1e3e564c9015d0f24e3627ce12c2dec3a0601a27892::iolli {
    struct IOLLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IOLLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IOLLI>(arg0, 9, b"IOLLI", b"Olli", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IOLLI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IOLLI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IOLLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

