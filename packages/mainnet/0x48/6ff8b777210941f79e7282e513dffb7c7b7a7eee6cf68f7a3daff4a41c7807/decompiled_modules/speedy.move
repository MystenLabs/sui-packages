module 0x486ff8b777210941f79e7282e513dffb7c7b7a7eee6cf68f7a3daff4a41c7807::speedy {
    struct SPEEDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEEDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEEDY>(arg0, 6, b"SPEEDY", b"SPEEDYSUI", b"Im Speedy | Achiever of Goals | Practitioner of Patience | Breaker of Finish Lines ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xw_Wlhgx_K_400x400_c890067fa5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEEDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEEDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

