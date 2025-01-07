module 0x4700c160a3f4ea9fc84bc56fde8f7f02da283bee1c8b1758fd573f488f6c006e::creatoryuan_coin {
    struct CREATORYUAN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATORYUAN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREATORYUAN_COIN>(arg0, 6, b"CYC", b"CreatorYuan Coin", b"this is CreatorYuan Coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/15226478?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREATORYUAN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREATORYUAN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

