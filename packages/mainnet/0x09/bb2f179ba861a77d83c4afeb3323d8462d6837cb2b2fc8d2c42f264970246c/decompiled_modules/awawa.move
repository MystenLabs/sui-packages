module 0x9bb2f179ba861a77d83c4afeb3323d8462d6837cb2b2fc8d2c42f264970246c::awawa {
    struct AWAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAWA>(arg0, 9, b"AWAWA", b"Screaming Hyrax on SUI", b"AWAWA - Screaming Hyrax meme token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcJ3roBG7gm2MxNucHVfp9kYuFzdwteDxmUQsaAv5U4rh")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AWAWA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWAWA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAWA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

