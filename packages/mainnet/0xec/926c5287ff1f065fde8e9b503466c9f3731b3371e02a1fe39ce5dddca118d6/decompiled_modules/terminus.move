module 0xec926c5287ff1f065fde8e9b503466c9f3731b3371e02a1fe39ce5dddca118d6::terminus {
    struct TERMINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINUS>(arg0, 6, b"TERMINUS", b"Terminus", b"First City on Mars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731751075386.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERMINUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

