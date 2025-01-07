module 0xbfc8c565d331861018b47ac8165a4f5f1ae06e9870ec56e87aa381e85b2968a7::cwf {
    struct CWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWF>(arg0, 6, b"CWF", b"Crab Wif Fish", b"Who does BRO think HE IS?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crab_fish_d4c49ce691.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

