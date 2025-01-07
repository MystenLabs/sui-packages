module 0xcaa4bdab8787281f8cf3ee9606badd2847a114cb890e0a66a49cd4ff992e2a65::som {
    struct SOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOM>(arg0, 9, b"SOM", b"SOMI", b"SOMI is a meme coin which signifies \"follow\" in it native language... with SOMI, there are lot of fellowship with other meme coin... we are not just Following meme coin creation but to bring in a fellowship with all meme-coin and all other cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb2dd7f5-0d2d-47b7-8d6d-92d8c3e5d88f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

