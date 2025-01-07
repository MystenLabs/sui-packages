module 0x78a617d9ff0c816dcc211725cec377d51be469450781d298495b21ff16eb03c0::batboy {
    struct BATBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATBOY>(arg0, 6, b"BATBOY", b"BATBOY ON SUI", b"BATBOY SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_49_e6b56c38a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

