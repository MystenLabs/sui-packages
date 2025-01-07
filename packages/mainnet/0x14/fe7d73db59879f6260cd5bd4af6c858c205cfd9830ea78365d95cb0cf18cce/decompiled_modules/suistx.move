module 0x14fe7d73db59879f6260cd5bd4af6c858c205cfd9830ea78365d95cb0cf18cce::suistx {
    struct SUISTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTX>(arg0, 6, b"SUISTX", b"SATOSHI 6900", b"SATOSHI 6900 on SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3519_ccc4dc9114.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTX>>(v1);
    }

    // decompiled from Move bytecode v6
}

