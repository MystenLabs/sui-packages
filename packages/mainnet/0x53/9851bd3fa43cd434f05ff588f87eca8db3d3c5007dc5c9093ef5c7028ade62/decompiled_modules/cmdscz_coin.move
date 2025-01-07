module 0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin {
    struct CMDSCZ_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CMDSCZ_COIN>, arg1: 0x2::coin::Coin<CMDSCZ_COIN>) {
        0x2::coin::burn<CMDSCZ_COIN>(arg0, arg1);
    }

    fun init(arg0: CMDSCZ_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMDSCZ_COIN>(arg0, 9, b"CMDSCZ", b"CMDSCZ_COIN", b"CMDSCZ Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169383631")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMDSCZ_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMDSCZ_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CMDSCZ_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CMDSCZ_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

