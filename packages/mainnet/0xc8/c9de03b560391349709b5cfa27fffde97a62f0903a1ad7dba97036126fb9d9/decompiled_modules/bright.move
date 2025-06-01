module 0xc8c9de03b560391349709b5cfa27fffde97a62f0903a1ad7dba97036126fb9d9::bright {
    struct BRIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIGHT>(arg0, 6, b"BRIGHT", b"BRIGHTDAO", b"Launch & trade meme coins on AVAX with no bonding curves or token locks. Fast, transparent, and built for creators, traders, and the Web3 community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibsj6uyj2mjxkb6xbcd7txkjnuh3wel64hi7ujb5h45hfobxqp7cy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRIGHT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

