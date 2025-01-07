module 0x3d72cb18c421318f991a0d71f35aee2f632d0dba1c5f84689abe1df39d7920e4::suimmer {
    struct SUIMMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMMER>(arg0, 6, b"SUIMMER", b"Suimmer The Chosen One", x"5468652043686f73656e204f6e652e200a4f6e6520696e20612062696c6c696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031354_92cc14a846.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

