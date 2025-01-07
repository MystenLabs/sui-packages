module 0x9dba80f1aa2bb039b7da5aecdde81e4569757470c7080f0c04e32ef2a1023b56::suiceber_coin {
    struct SUICEBER_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICEBER_COIN>, arg1: 0x2::coin::Coin<SUICEBER_COIN>) {
        0x2::coin::burn<SUICEBER_COIN>(arg0, arg1);
    }

    fun init(arg0: SUICEBER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICEBER_COIN>(arg0, 9, b"SUICEBER", b"SUICEBER_COIN", b"Suiceber Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/182899206?v=4&size=64")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICEBER_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICEBER_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICEBER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICEBER_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

