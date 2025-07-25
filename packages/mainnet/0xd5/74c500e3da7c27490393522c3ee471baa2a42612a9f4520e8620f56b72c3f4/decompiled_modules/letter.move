module 0xd574c500e3da7c27490393522c3ee471baa2a42612a9f4520e8620f56b72c3f4::letter {
    struct LETTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LETTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LETTER>(arg0, 6, b"LETTER", b"Letter Token", b"Letter coded.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihmy4332e7jf65rdtetesbh6yvlmhgvufcyo2ppuy5wq2yzxkmyk4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LETTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LETTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

