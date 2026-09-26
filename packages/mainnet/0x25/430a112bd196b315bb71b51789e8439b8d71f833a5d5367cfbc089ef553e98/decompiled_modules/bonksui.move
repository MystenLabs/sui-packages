module 0x25430a112bd196b315bb71b51789e8439b8d71f833a5d5367cfbc089ef553e98::bonksui {
    struct BONKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKSUI>(arg0, 6, b"BONKSUI", b"BONKONSUI", b"Closing the gap between the BONK on SOL to sui with portal bridge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1790380856543.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONKSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

