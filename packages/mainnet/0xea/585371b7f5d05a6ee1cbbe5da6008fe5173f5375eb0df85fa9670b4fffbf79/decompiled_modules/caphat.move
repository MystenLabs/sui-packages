module 0xea585371b7f5d05a6ee1cbbe5da6008fe5173f5375eb0df85fa9670b4fffbf79::caphat {
    struct CAPHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPHAT>(arg0, 6, b"CAPHAT", b"Sui Caphat", b"Just a Hat Cat - memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010858_153238ebf1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

