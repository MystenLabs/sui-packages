module 0xd29b38b0d501171250f4136a191995fd37acdc1e44757ad740c8be10be13dad1::sr {
    struct SR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SR>(arg0, 6, b"SR", b"Sui Rep", b"meme coin inspired by Giverep on Twitter X Backed by GIVEREP COMMUNITY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibukhfptsx24rgnggloj6r46oncxkcd4bogfjxyxmp3mogo34ugp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

