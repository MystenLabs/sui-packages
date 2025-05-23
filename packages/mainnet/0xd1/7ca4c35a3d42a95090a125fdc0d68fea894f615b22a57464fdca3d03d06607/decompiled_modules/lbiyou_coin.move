module 0xd17ca4c35a3d42a95090a125fdc0d68fea894f615b22a57464fdca3d03d06607::lbiyou_coin {
    struct LBIYOU_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LBIYOU_COIN>, arg1: 0x2::coin::Coin<LBIYOU_COIN>) {
        0x2::coin::burn<LBIYOU_COIN>(arg0, arg1);
    }

    fun init(arg0: LBIYOU_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBIYOU_COIN>(arg0, 9, b"LBIYOU_COIN", b"lbiyou", b"first coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/104566270?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBIYOU_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBIYOU_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LBIYOU_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LBIYOU_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

