module 0xe811f1d19f2d67ca1e1e7337c450ce6049ce6d25b5acc2910f44b8cb73cfcc4b::suimeme {
    struct SUIMEME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIMEME>, arg1: 0x2::coin::Coin<SUIMEME>) {
        0x2::coin::burn<SUIMEME>(arg0, arg1);
    }

    fun init(arg0: SUIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEME>(arg0, 9, b"suimeme", b"smme", b"Sui Meme Agregator - suimeme.vip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/BRPtYVl.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEME>>(v1);
        0x2::coin::mint_and_transfer<SUIMEME>(&mut v2, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEME>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIMEME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIMEME>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

