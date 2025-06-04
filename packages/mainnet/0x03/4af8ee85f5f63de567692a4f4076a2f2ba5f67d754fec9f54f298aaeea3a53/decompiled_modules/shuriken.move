module 0x34af8ee85f5f63de567692a4f4076a2f2ba5f67d754fec9f54f298aaeea3a53::shuriken {
    struct SHURIKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHURIKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHURIKEN>(arg0, 6, b"SHURIKEN", b"Shuriken on sui", b"Ken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidm54assbhin7vw3cc72wjxzofdefejs72scm22zkgk3ampzkiisy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHURIKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHURIKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

