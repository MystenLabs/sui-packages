module 0xd6187240cd43836d9d33345d0dcabc531cc287a327f0dea9d9f234364712857a::monki {
    struct MONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKI>(arg0, 6, b"MONKI", b"Monki", b"Monki, the meditating monkey monk, brings zen to the chaos of crypto. Hold $MONKI and let this banana-loving guru guide you to golden gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012614_2a56e6eb08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

