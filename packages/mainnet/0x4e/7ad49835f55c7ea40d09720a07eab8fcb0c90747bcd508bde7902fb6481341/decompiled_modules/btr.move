module 0x4e7ad49835f55c7ea40d09720a07eab8fcb0c90747bcd508bde7902fb6481341::btr {
    struct BTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTR>(arg0, 6, b"BTR", b"BTR", b"BTR ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWDUbwmFuPDy9mW5jRk4h7v1nhnXUr1jmmna6jHA3Npfo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

