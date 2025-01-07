module 0x3a7dd6bf2e0fa17e6297d308adc69a55b285418385b820003fec2f4f8d914081::rflag {
    struct RFLAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFLAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFLAG>(arg0, 6, b"RFLAG", b"RED FLAG", b"red flag guys, red flag...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pngtree_red_flag_isolated_on_white_background_png_image_4750298_c1d567e970.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFLAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RFLAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

