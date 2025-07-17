module 0x1baf2c21f5e7c367311b6afd6fbb17a2252535fb834a35136f62d5db30bec846::grok_male_companion {
    struct GROK_MALE_COMPANION has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK_MALE_COMPANION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK_MALE_COMPANION>(arg0, 6, b"Grok male companion", b"Valentine", b"His name will be Valentine, after the protagonist in Stranger in a Strange Land, the Heinlein book where our AI name,Grok was created.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifasfswlzhhv5w4vxkcsxf5ovosix6gggzww4rk6wvjqxvdrtkccq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK_MALE_COMPANION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GROK_MALE_COMPANION>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

