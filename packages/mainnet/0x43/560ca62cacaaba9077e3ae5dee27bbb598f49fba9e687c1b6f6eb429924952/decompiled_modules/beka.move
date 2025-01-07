module 0x43560ca62cacaaba9077e3ae5dee27bbb598f49fba9e687c1b6f6eb429924952::beka {
    struct BEKA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEKA>, arg1: 0x2::coin::Coin<BEKA>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEKA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BEKA>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BEKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEKA>(arg0, 6, b"BEKA", b"Beka Sui", x"2442454b412c2074686520626f6c6420616e642069727265766572656e7420626164206769726c206f66207468652063727970746f63757272656e637920776f726c642e2020e29c85574542534954452068747470733a2f2f7777772e62656b61636c75622e66756e2f2020e29c85545749545445522068747470733a2f2f782e636f6d2f62656b615f737569202020e29c8554454c454752414d2068747470733a2f2f742e6d652f62656b61737569706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmRauh47nGK9qZyxip762SYX9uiZHWqbC2B7eAZeGunCja")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BEKA>, arg1: 0x2::coin::Coin<BEKA>) : u64 {
        0x2::coin::burn<BEKA>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BEKA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BEKA> {
        0x2::coin::mint<BEKA>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

