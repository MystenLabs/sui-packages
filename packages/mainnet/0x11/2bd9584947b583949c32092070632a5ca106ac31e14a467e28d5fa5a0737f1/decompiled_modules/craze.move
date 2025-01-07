module 0x112bd9584947b583949c32092070632a5ca106ac31e14a467e28d5fa5a0737f1::craze {
    struct CRAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAZE>(arg0, 6, b"CRAZE", b"CrazyOnSui", x"456d627261636520746865204d61646e6573730a546865204e6578742042696720436f6d6d756e697479204d656d65204352415a45206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001794_23ebd534b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

