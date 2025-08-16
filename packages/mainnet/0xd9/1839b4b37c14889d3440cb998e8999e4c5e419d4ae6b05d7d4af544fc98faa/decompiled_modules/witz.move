module 0xd91839b4b37c14889d3440cb998e8999e4c5e419d4ae6b05d7d4af544fc98faa::witz {
    struct WITZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITZ>(arg0, 6, b"WITZ", b"The Whiz", b"Whiz the SUI Wizard is a mystical meme force in the SUIverse, casting spells of hype and channeling pure degen energy to unleash magic, memes, and chaos across the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicfh56hq6yeglaxwwcnbouycoajrbqvofkpid2rujorbvnympfw7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WITZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

