module 0x536bc22d3544c6d1ecc22896fa94881e5c7d86c720d27a8e3c509728ef3a7443::sbrat {
    struct SBRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRAT>(arg0, 6, b"SBRAT", b"SUPERBRAT", b"SUPER BRAT is more than just a meme token, it's a community-driven cryptocurrency designed to bring fun and innovation to the Sui Network. We aim to create a vibrant ecosystem where every holder can benefit from our unique approach to blockchain technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigfueetgrcb4oy4bngvpixhmunyn3zzyh7slzs3rlt6bg6jauwvge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBRAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

