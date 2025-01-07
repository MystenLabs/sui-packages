module 0xb073dc5402fb82ddf284cd9a257e2df2b96286bee74b301d50861f282ba018b6::dont {
    struct DONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONT>(arg0, 6, b"DONT", b"DONT BUY", b"Do not buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734743879782.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

