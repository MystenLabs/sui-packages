module 0x76327c915aea5b9b2edfc9347738b9b4e829d777b249c31410fdba997dff6054::cbot {
    struct CBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBOT>(arg0, 6, b"CBOT", b"CBOT on Sui", b"The next generation trading bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_2_15f0742efc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

