module 0x4acb39382b7bd678f3e29b3986b52ca8663c8c8e06eb5253ef69a52cb09002a1::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 6, b"SUCK", b"DUCK On Sui", b"First OG DUCK on SUI $SUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/duck3_removebg_preview_c6c4e4d473.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

