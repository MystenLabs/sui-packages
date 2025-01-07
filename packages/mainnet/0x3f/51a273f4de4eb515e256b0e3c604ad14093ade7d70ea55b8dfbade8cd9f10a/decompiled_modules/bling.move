module 0x3f51a273f4de4eb515e256b0e3c604ad14093ade7d70ea55b8dfbade8cd9f10a::bling {
    struct BLING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLING>(arg0, 6, b"BLING", b"BlingDeng", x"224469616d6f6e6473206172652061206769726c73206265737420667269656e64220a0a2d4d6172696c796e204d6f6e726f65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_deng_27c6cf89f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLING>>(v1);
    }

    // decompiled from Move bytecode v6
}

