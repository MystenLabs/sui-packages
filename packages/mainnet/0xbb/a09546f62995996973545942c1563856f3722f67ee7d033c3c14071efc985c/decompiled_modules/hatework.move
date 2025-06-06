module 0xbba09546f62995996973545942c1563856f3722f67ee7d033c3c14071efc985c::hatework {
    struct HATEWORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HATEWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HATEWORK>(arg0, 6, b"HATEWORK", b"I HATE WORK", b"Do you hate work? Tired of everyday bs? Join the community! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_06_05_at_11_05_11_PM_77eace30e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HATEWORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HATEWORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

