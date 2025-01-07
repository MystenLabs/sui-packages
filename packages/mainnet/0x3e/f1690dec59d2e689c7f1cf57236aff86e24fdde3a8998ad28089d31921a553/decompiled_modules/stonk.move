module 0x3ef1690dec59d2e689c7f1cf57236aff86e24fdde3a8998ad28089d31921a553::stonk {
    struct STONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONK>(arg0, 9, b"STONK", b"STONK", b"Stonk on sui https://t.me/suistonk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STONK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

