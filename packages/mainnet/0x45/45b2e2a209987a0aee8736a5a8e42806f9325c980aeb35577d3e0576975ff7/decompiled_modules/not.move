module 0x4545b2e2a209987a0aee8736a5a8e42806f9325c980aeb35577d3e0576975ff7::not {
    struct NOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOT>(arg0, 9, b"NOT", b"Notcoin", b"Probably nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b4a5f4f-de95-47e7-9854-50ed40cf97fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

