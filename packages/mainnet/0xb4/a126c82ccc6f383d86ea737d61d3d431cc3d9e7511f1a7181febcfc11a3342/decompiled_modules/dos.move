module 0xb4a126c82ccc6f383d86ea737d61d3d431cc3d9e7511f1a7181febcfc11a3342::dos {
    struct DOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOS>(arg0, 6, b"DOS", b"Dragon on Sui", b"Dragon on Sui is a meme coin inspired by the mythical creature dragon, symbolizing strength and power. Join the community and ride the dragon to the moon! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/BsNaZC.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

