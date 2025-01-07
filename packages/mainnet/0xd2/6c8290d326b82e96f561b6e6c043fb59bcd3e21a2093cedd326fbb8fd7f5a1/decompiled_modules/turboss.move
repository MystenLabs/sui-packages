module 0xd26c8290d326b82e96f561b6e6c043fb59bcd3e21a2093cedd326fbb8fd7f5a1::turboss {
    struct TURBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSS>(arg0, 6, b"TURBOSS", b"TurBoss", b"Unofficial http://Turbo.fun Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731072022897.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

