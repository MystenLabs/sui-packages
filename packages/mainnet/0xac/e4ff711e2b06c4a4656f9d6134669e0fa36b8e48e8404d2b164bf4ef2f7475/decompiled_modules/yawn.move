module 0xace4ff711e2b06c4a4656f9d6134669e0fa36b8e48e8404d2b164bf4ef2f7475::yawn {
    struct YAWN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YAWN>, arg1: 0x2::coin::Coin<YAWN>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YAWN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YAWN>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: YAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWN>(arg0, 6, b"YAWN", b"Yawn On Sui", x"4d656574205961776e2c2074686520736c65657069657374206d656d626572206f66207468652067726f75702e202020e29c85574542534954452068747470733a2f2f7777772e7961776e7375692e78797a2f2020e29c85545749545445522068747470733a2f2f782e636f6d2f7961776e5f5f737569202020e29c8554454c454752414d2068747470733a2f2f742e6d652f7961776e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmUC1bkJ83pPpPgAHfu5dHUS3c1RzTFyioHwKSmUSkKosx")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<YAWN>, arg1: 0x2::coin::Coin<YAWN>) : u64 {
        0x2::coin::burn<YAWN>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<YAWN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<YAWN> {
        0x2::coin::mint<YAWN>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

