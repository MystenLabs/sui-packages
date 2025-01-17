module 0x9f5ca4fd896c170c695625b26ff018aaf5899a57f79e819069d07c825f294aa4::ryze {
    struct RYZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYZE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RYZE>(arg0, 6, b"RYZE", b"RyzeNet by SuiAI", b"Ryze Network is designed to deploy specialized agents for attention tracking, trading, network integration, and management.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2179_532e81ac69.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RYZE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYZE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

