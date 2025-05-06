module 0xa764fc317ead9516eabc511de2e791726dddca5f7f54f4cc9237071edcca3c0d::chimpe {
    struct CHIMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIMPE>(arg0, 6, b"CHIMPE", b"Chimpe The Magic Shrimp", x"4348494d504520544845204d4147494320534852494d500a0a4920616d206368696d70652e2049276d206e6f742061206361742c20646f672c206f722066726f672e204920616d2061206d6167696320736872696d7020626f726e20696e2074686520536561206f66205375692e20646f6e277420756e646572657374696d617465206120736872696d7021212062657369646573206265696e672064656c6963696f75732e0a0a4368696d70652077696c6c206265636f6d65206b696e67206f6620746865207365612c20616e642067657420726964206f662074686520646f6d696e616e6365206f6620636174732c20646f67732c206576656e2066726f67732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigpdnr5swpfrakjur3u7e2k5jeisjufzcaanphrwcjviygru6xntm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIMPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHIMPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

