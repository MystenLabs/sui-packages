module 0x8c0043fe262f7f891264c6f9c0a21c0e1103a3848f7133e358363e1a4f93a408::ffm {
    struct FFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFM>(arg0, 6, b"FFM", b"FORTYFIVEMILLIONS", b"No website. No twitter. No telegram. Just 45M coin to pump it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiegkgeqdvewrjt7b6t2ggssev6usjbt7osktbrdpjoeejdgb2jmiy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FFM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

