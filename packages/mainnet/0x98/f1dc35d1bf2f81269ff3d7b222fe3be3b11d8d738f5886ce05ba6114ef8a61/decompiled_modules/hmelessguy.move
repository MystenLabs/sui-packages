module 0x98f1dc35d1bf2f81269ff3d7b222fe3be3b11d8d738f5886ce05ba6114ef8a61::hmelessguy {
    struct HMELESSGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMELESSGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMELESSGUY>(arg0, 6, b"HMELESSGUY", b"homeless guy", b"just a homeless guy on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735840448116.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMELESSGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMELESSGUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

