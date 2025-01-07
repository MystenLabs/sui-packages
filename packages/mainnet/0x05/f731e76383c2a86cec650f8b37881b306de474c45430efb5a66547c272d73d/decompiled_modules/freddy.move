module 0x5f731e76383c2a86cec650f8b37881b306de474c45430efb5a66547c272d73d::freddy {
    struct FREDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREDDY>(arg0, 6, b"FREDDY", b"Freddysuibear", b"Freddysuibear UR UR UR UR UR UR UR UR  UR UR UR UR UR UR UR UR  UR UR UR UR UR UR UR UR  UR UR UR UR UR UR UR UR  UR UR UR UR UR UR UR UR  UR UR UR UR UR UR UR UR  UR UR UR UR UR UR UR UR  UR UR UR UR UR UR UR UR ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949720616.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREDDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

