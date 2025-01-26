module 0xca4fca61a4783060e7887257d34187a7ccf4c115f8ebfc60419462a6436bb9d0::issacrobot {
    struct ISSACROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISSACROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISSACROBOT>(arg0, 6, b"IssacRobot", b"Issac Robot", b"Issac The Cute Robot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/white_isaac_01_fc19ff5e99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISSACROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISSACROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

