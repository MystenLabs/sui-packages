module 0x42c3484af9d7d74598a935fc532541684601baad635636f3e5f007d710c71950::swog {
    struct SWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOG>(arg0, 6, b"SWOG", b"Introducing sui $SWOG, Coming in full gangster force to take over the sui", b"WE ARE HERE $SWOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihavyzm35yym7kpixkxsmmsy47oiecdzdvwdxsfesw34zovzwqx4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

