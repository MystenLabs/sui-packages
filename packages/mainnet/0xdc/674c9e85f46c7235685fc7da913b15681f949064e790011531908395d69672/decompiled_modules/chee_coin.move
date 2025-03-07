module 0xdc674c9e85f46c7235685fc7da913b15681f949064e790011531908395d69672::chee_coin {
    struct CHEE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHEE_COIN>, arg1: 0x2::coin::Coin<CHEE_COIN>) {
        0x2::coin::burn<CHEE_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHEE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHEE_COIN>>(0x2::coin::mint<CHEE_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHEE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEE_COIN>(arg0, 6, b"CHEE_COIN", b"CHEE_COIN", b"chee coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/chee-qi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEE_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CHEE_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

