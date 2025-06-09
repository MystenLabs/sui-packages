module 0x616a9d399e96f2794005d227697bf64af91916d3fbe51ba00a95ae3648de73bc::pelp {
    struct PELP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELP>(arg0, 6, b"PELP", b"Pelipper on sui", b"po", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiamclokbu7bcmob2ey3x2qqyh722vfxqlypubnoqwrzc5usvbzkdi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PELP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

