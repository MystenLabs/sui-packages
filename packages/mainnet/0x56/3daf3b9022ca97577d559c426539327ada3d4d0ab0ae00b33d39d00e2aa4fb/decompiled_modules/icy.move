module 0x563daf3b9022ca97577d559c426539327ada3d4d0ab0ae00b33d39d00e2aa4fb::icy {
    struct ICY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICY>(arg0, 6, b"ICY", b"Icy Sui", b"Icy, the first polar bear on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieqc43qbqurtyitqooxyxt7eelocylxafty4gbeh332shaprm73ce")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

