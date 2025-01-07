module 0x26c52507cbd06684da94a201bc6228acce8337bb768bd423f7a5d8db5fe28598::jmagicc_coin {
    struct JMAGICC_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JMAGICC_COIN>, arg1: 0x2::coin::Coin<JMAGICC_COIN>) {
        0x2::coin::burn<JMAGICC_COIN>(arg0, arg1);
    }

    fun init(arg0: JMAGICC_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMAGICC_COIN>(arg0, 9, b"JMAGICC", b"Jmagicc Coin", b"Jmagicc Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/58356228")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMAGICC_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JMAGICC_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JMAGICC_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JMAGICC_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

