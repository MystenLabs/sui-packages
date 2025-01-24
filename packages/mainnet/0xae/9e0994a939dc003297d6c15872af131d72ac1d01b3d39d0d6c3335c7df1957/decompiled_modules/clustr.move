module 0xae9e0994a939dc003297d6c15872af131d72ac1d01b3d39d0d6c3335c7df1957::clustr {
    struct CLUSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLUSTR>(arg0, 6, b"CLUSTR", b"CLUSTR ON SUI", b"Clstr Labs - Researching the future of open source autonomous economic agentic ecosystems. Accelerating the Emergence of AGI, one agent at a time. Building on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029190_e5943444a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLUSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

