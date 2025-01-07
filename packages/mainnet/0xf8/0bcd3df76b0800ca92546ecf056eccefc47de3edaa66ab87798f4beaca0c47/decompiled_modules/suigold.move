module 0xf80bcd3df76b0800ca92546ecf056eccefc47de3edaa66ab87798f4beaca0c47::suigold {
    struct SUIGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOLD>(arg0, 9, b"SUIGOLD", b"SUIGOLD", b"SuiGold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGOLD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOLD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

