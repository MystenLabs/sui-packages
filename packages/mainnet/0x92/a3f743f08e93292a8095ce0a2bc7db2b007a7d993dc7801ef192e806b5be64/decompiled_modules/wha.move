module 0x92a3f743f08e93292a8095ce0a2bc7db2b007a7d993dc7801ef192e806b5be64::wha {
    struct WHA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WHA>, arg1: 0x2::coin::Coin<WHA>) {
        0x2::coin::burn<WHA>(arg0, arg1);
    }

    fun init(arg0: WHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHA>(arg0, 5, b"SLERF", b"SLERF", b"SLERF token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/7BgBvyjrZX1YKz4oh9mjb8ZScatkkwb8DzFx7LoiVkM3.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0x5002247a747ccf9ca743726a9a768247e3ebea204e247f23a3b4c6f212db30d0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WHA>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<WHA>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WHA>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

