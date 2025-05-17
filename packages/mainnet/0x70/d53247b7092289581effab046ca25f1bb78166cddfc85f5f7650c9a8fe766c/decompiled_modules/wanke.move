module 0x70d53247b7092289581effab046ca25f1bb78166cddfc85f5f7650c9a8fe766c::wanke {
    struct WANKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANKE>(arg0, 6, b"WANKE", b"Wanke On Sui", b"Meet Wanke. The Retardiest one.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigiy2vyfbskccuq2mq3w53nlvdvoxe6y6kmvvhmp3ae75levpu3fq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WANKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

