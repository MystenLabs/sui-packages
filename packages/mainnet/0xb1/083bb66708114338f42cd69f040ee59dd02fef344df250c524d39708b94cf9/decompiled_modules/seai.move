module 0xb1083bb66708114338f42cd69f040ee59dd02fef344df250c524d39708b94cf9::seai {
    struct SEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAI>(arg0, 7, b"SEAI", b"SeloAi", b"AI TECHNOLOGY COMPANY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/055f4530-dc0d-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAI>>(v1);
        0x2::coin::mint_and_transfer<SEAI>(&mut v2, 11000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

