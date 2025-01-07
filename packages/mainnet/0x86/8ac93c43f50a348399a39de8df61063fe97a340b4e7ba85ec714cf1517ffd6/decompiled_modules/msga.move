module 0x868ac93c43f50a348399a39de8df61063fe97a340b4e7ba85ec714cf1517ffd6::msga {
    struct MSGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSGA>(arg0, 6, b"MSGA", b"MAKE SUI GREAT AGAIN", b"MAKE SUI GREAT AGAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_crisp_bright_blue_baseball_cap_with_a_curve_1_463fcb3ea1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

