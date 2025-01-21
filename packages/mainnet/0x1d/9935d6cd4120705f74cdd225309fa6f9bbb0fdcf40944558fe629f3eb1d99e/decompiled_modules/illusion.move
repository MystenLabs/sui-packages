module 0x1d9935d6cd4120705f74cdd225309fa6f9bbb0fdcf40944558fe629f3eb1d99e::illusion {
    struct ILLUSION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILLUSION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILLUSION>(arg0, 9, b"ILLUSION", b"The ILLUSION Project", b"The Illusion is a once-in-a-generation cultural phenomenon. APE 1 SOL MAX. Dont jeet. Make sure you read our Apepaper Pro. Trust me, this is a GG project. You lucky bastards are the real illusion-nati. See you in Valhalla.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSzHt7br8DD1UmnVkNVaJgiARpm4QRpWhVvkaJHeTgqFD")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ILLUSION>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILLUSION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILLUSION>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

