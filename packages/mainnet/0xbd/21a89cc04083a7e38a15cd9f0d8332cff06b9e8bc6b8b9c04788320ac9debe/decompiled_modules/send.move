module 0xbd21a89cc04083a7e38a15cd9f0d8332cff06b9e8bc6b8b9c04788320ac9debe::send {
    struct SEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEND>(arg0, 6, b"SEND", b"Sendoor", b"YOUR ONLY WAY TO SEND IT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_e118f5939e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

