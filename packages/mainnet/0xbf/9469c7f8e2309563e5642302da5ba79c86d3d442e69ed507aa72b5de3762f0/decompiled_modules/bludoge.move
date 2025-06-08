module 0xbf9469c7f8e2309563e5642302da5ba79c86d3d442e69ed507aa72b5de3762f0::bludoge {
    struct BLUDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUDOGE>(arg0, 6, b"BLUDOGE", b"Bluedoge", b"Bluedoge the bulldog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieyye3gybt6uekjymriajmtufmaiznj3vxue743hjr4a45i5gyrqu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUDOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

