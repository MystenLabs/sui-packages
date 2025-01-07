module 0x6d03aba19c975b2750427b6e014d1b5d7caa2af83f042a1acaffeed6d2f61b41::suifun {
    struct SUIFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUN>(arg0, 6, b"SUIFUN", b"SuiFun", x"5370696e20616e642057696e207768696c6520656e6a6f79696e672066617374207061796f75747320746f74616c20616e6f6e796d69747920616e642070726f7661626c7920666169722067616d696e6720657870657269656e63652e0a0a57656273697465203a20687474703a2f2f73756966756e2e6f6e6c696e652f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035080_b850ccb176.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

