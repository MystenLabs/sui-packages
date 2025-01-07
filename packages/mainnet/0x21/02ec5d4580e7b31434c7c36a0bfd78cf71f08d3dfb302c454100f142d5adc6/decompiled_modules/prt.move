module 0x2102ec5d4580e7b31434c7c36a0bfd78cf71f08d3dfb302c454100f142d5adc6::prt {
    struct PRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRT>(arg0, 6, b"PRT", b"PURTEMERDE", x"6578706572696d656e74616c2070726f6a65637420666f72206d756c74692d756e697665727365204e4654206d61726b6574706c6163650a68747470733a2f2f6f70656e7365612e696f2f636f6c6c656374696f6e2f70757274656d657264656e6674", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_35_1024x1024_f86f378079.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

