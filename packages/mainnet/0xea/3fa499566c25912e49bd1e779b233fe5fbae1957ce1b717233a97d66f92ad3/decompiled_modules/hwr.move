module 0xea3fa499566c25912e49bd1e779b233fe5fbae1957ce1b717233a97d66f92ad3::hwr {
    struct HWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HWR>(arg0, 6, b"HWR", b"He_who_remains by SuiAI", b"appears ageless or of an indeterminate age.Elegant, possibly anachronistic attire; think of a blend between a modern suit and medieval elements.Neat, possibly gray or silver to denote wisdom and age, styled in a manner that's out of time but fitting for someone in control.Deep, knowing, with a hint of mirth or mischief, reflecting centuries of experience", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000028315_82f6af217c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HWR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

