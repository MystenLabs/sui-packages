module 0xaf561b6a7a4833931ec88daf1f553184086f40e808d2a043b2f70ba76c351fd0::nfa {
    struct NFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFA>(arg0, 4, b"NFA", b"Not Ferra Actually", b"Not Ferra Actually", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihbw5bd2qtbatrg6zupokw3efhp5nr5vfburdfwjpxt2rwn5vn5pm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NFA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NFA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

