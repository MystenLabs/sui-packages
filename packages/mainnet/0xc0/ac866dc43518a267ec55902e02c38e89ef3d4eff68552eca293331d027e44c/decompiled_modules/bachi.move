module 0xc0ac866dc43518a267ec55902e02c38e89ef3d4eff68552eca293331d027e44c::bachi {
    struct BACHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACHI>(arg0, 6, b"BACHI", b"Sui Bachi", b"I'm a memecoin based on my owner Chiweenie Bachi. I'm 3 years old. Sarcastic, loveable, full of piss an venegar because i'm half chihuahua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigx42qdss6eusf2ulcplobjnu6dphwostz2q5vq2lzzu4xd54szei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BACHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

