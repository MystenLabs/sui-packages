module 0x368d0e07d5fcbc593454376d1f5e42c2eb8ea38d27e425846b071aaba2691dc1::lilpepe {
    struct LILPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LILPEPE>, arg1: 0x2::coin::Coin<LILPEPE>) {
        0x2::coin::burn<LILPEPE>(arg0, arg1);
    }

    fun init(arg0: LILPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILPEPE>(arg0, 9, b"LILPEPE", b"Little Pepe", b"Enter the new world order with LILPEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/N6K9wR6D/0xa2209a2b7cdb0a15457322199fe45bdbad72c48f.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LILPEPE>>(v1);
        0x2::coin::mint_and_transfer<LILPEPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILPEPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LILPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LILPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

