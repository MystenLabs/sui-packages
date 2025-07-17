module 0xc78294acd033b965b1a9b70a99cab84c72ddab0eb3d60a1c28b664359e17110::valentine {
    struct VALENTINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VALENTINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VALENTINE>(arg0, 6, b"Valentine", b"Grok male companion", b"His name will be Valentine, after the protagonist in Stranger in a Strange Land, the Heinlein book where our AI name,Grok was created.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifasfswlzhhv5w4vxkcsxf5ovosix6gggzww4rk6wvjqxvdrtkccq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VALENTINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VALENTINE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

