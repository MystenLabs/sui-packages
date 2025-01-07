module 0x1b053b5918667f740ba59d310fdfa231f35ee1ab04a8c9382f81e5727beb43cb::shitdicknips {
    struct SHITDICKNIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITDICKNIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITDICKNIPS>(arg0, 6, b"SHITDICKNIPS", b"SHITTING DICK NIPPLES", b"HOLY SHITTING DICK NIPPLES YOU GUYS WILL BUY FUCKING ANYTHING. RETARDS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHITTINGDICKNIPS_c0cd40b946.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITDICKNIPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITDICKNIPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

