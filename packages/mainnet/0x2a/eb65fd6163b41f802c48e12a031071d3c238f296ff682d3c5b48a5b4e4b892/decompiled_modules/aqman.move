module 0x2aeb65fd6163b41f802c48e12a031071d3c238f296ff682d3c5b48a5b4e4b892::aqman {
    struct AQMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQMAN>(arg0, 6, b"AQMAN", b"AQUA MAN", b"Beautiful seabed ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049877_af547cb619.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

