module 0xa1575946eef517096f5787451c594431100b28167559cf04050403baa13e5b5f::suipei {
    struct SUIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEI>(arg0, 6, b"SUIPEI", b"The Cat Warrior", x"546865206361742077617272696f72206f6e2053756920200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipei_777c76042b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

