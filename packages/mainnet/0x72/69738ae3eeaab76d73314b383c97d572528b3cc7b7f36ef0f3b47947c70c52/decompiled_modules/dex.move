module 0x7269738ae3eeaab76d73314b383c97d572528b3cc7b7f36ef0f3b47947c70c52::dex {
    struct DEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEX>(arg0, 6, b"DEX", b"Pokedex on sui", b"PODEX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiab3irmgksklippz7vh5ryr7dhqmn2u7xvnn5cfxymjmqgbro52qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

