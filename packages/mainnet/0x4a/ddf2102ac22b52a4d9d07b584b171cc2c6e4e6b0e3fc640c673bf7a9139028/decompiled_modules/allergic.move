module 0x4addf2102ac22b52a4d9d07b584b171cc2c6e4e6b0e3fc640c673bf7a9139028::allergic {
    struct ALLERGIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLERGIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLERGIC>(arg0, 6, b"ALLERGIC", b"Allergic To Work", b"You're tired of 9 to 5 - f*ck that! Don't let standard restrictions dictate how you live your life. It's time to break free and start doing what truly brings you joy and freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_11_15_D_14_50_31_3af078451e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLERGIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALLERGIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

