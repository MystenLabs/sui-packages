module 0x8512380b5d9b4be6ebe12b167ada3d0f28653405ebbec72566b1b1206486493d::fogs_coin {
    struct FOGS_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOGS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOGS_COIN>(arg0, 9, b"FOGS", b"Fogs Coin", b"A custom coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://razepunk.win")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOGS_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FOGS_COIN>>(0x2::coin::mint<FOGS_COIN>(&mut v2, 21000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOGS_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

