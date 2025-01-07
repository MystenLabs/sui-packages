module 0x1779fde32be900165156516e3efa48935ed594d7bc0784be64465cbfe2b57ea6::suius {
    struct SUIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUS>(arg0, 9, b"SUIUS", b"Suius Maximus", b"SUIUS MAXIMUS, the divine emperor of the SUI blockchain, blessed by the ancient meme gods. Born in the depths of crypto winter, forged in the fires of degen wisdom. The most based of all tokens, for we are all gonna make it. In SUIUS we trust, through pump and dump, 100x or doom. WAGMI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdcVkrNshBGdH3KTZmya15pzo71dWHSkhGd3qd4Ppvgp4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIUS>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

