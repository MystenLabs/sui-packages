module 0xde07d75e422bcee5ce1bbb1a208b3b3ebc9953e6ad64f5e400833e828fc95abb::wasdm {
    struct WASDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASDM>(arg0, 6, b"Wasdm", b"jkh", b"ghasdg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifpd2yzx66kpoz5txm4l57lylv36ygbdfcpteafhkwvmnp3rxwaiy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WASDM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

