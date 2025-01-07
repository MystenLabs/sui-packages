module 0x7708ca9e1204c0837ce43e3dc0017d5738f30f8b29f74ef37fb030ce7a5e0cde::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"PEPE TRUMP", b"\"Pepe Trump\" combines Donald Trump with the internet meme Pepe the Frog. Pepe, created by Matt Furie, gained online fame and became associated with Trump supporters during the 2016 U.S. presidential election, often depicted wearing a \"Make America Great Again\" hat in memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmYoDS3P16rfwxiQ3NmwYJv96K1BrGjuToTurDV3JPS6V3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

