module 0xc9523f683256502be15ec4979098d510f67b6d3f0df02eebf124515014433270::pans {
    struct PANS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PANS>, arg1: 0x2::coin::Coin<PANS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PANS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PANS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PANS>>(0x2::coin::mint<PANS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANS>(arg0, 9, b"PANS", b"PandaSui Coin", b"PandaSui is the first meme coin within the Sui ecosystem to feature a self-burning mechanism.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibjxzgcww3454vovap3alohbyrp4am4cgy6tylc7hicdr4c33qsly?filename=Pans.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PANS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

