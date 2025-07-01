module 0x32ac1cc877f818f4fae65767dce0cc5b9422fb83d848f3283a326039ee7f92ed::joe {
    struct JOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOE>(arg0, 6, b"JOE", b"JOE on Sui", b"The people`s crypto. Just pure unfiltered degen energy and good vibes. Backed by memes. Powered by community. Joe isn`t here to save the world - he just wants to make it weirder and richer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib2rmojlrqw44c7ranm3qs6t36p2slos6mg2anz6ehwtsaoeznwcm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

