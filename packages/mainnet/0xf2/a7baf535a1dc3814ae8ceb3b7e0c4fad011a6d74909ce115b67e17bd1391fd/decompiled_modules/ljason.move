module 0xf2a7baf535a1dc3814ae8ceb3b7e0c4fad011a6d74909ce115b67e17bd1391fd::ljason {
    struct LJASON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LJASON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LJASON>(arg0, 6, b"LJASON", b"Little Jason", b"Little Jason on Sui For Friday the 13th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051737_3e9bd33b8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LJASON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LJASON>>(v1);
    }

    // decompiled from Move bytecode v6
}

