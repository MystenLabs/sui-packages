module 0x34645448dc7267a35862869ab282bc107e167de93eeccb4798bc8f6beb819add::sneko {
    struct SNEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SNEKO>(arg0, 6, b"SNEKO", b"Suiaineko by SuiAI", b"Sujai Neko veio do futuro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6794_9d66610fec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNEKO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEKO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

