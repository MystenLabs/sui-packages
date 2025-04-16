module 0xe93e4a1fdf352cdd496eb8ba9940e89ed2b87b816302f2256c45e1e76cfa6c59::ggwp {
    struct GGWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGWP>(arg0, 6, b"GGWP", b"GG", b"gg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigqusqg7cebtdpygwvu7mcymzefisdwrhbo6lqidcj326xctcmawq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGWP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GGWP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

