module 0x9ecf464a4fb93673f3f14194ee1d6f643e3c0908b985cc5fb4519adb5c6b8e82::hHAEDAL {
    struct HHAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHAEDAL>(arg0, 9, b"hHAEDAL", b"hHAEDAL Coin", b"hHAEDAL Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/lend/lend-vault/coin-icons/hhaedal_48624b6b.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHAEDAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHAEDAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

