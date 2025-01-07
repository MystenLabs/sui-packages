module 0x5ec2c00eeaf07cc1f2040acc06afbf7063815150a6ae2f4d9ba3f3ddfe57e575::btk {
    struct BTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTK>(arg0, 6, b"BTK", b"butakator", b"dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_05_31_at_12_15_56a_PM_e3cce145b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

