module 0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin {
    struct SD_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SD_COIN>, arg1: 0x2::coin::Coin<SD_COIN>) {
        0x2::coin::burn<SD_COIN>(arg0, arg1);
    }

    fun init(arg0: SD_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SD_COIN>(arg0, 9, b"SD", b"SD_COIN", b"StarryDesert Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/86464159")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SD_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SD_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SD_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SD_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

