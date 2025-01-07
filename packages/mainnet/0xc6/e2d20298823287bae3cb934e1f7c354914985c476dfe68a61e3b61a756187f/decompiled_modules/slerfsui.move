module 0xc6e2d20298823287bae3cb934e1f7c354914985c476dfe68a61e3b61a756187f::slerfsui {
    struct SLERFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLERFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLERFSUI>(arg0, 6, b"SLERFSUI", b"SLERF", b"i  am   SLERF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241014_122033_c3bda1b119.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLERFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLERFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

