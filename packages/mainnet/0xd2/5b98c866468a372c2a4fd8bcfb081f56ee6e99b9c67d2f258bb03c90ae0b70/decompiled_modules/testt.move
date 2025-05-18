module 0xd25b98c866468a372c2a4fd8bcfb081f56ee6e99b9c67d2f258bb03c90ae0b70::testt {
    struct TESTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTT>(arg0, 6, b"Testt", b"test", b"2312312312", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaxnnoqddzj5zzdftz4kpjb2mqnfsznk3lypj2k4mochimuaajhjq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

