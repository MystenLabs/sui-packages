module 0x2f1dc4b61606cb7376f315a36066f6dfbc15375e059cf3d56ff2f8ba52806459::louise {
    struct LOUISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOUISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOUISE>(arg0, 6, b"LOUISE", b"Zero no Tsukaima", b"The harem of ecchi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiep4xalladz43k3einf22qjprr4onmapwx3tnjc7u3ozyv4fiu2b4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOUISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOUISE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

