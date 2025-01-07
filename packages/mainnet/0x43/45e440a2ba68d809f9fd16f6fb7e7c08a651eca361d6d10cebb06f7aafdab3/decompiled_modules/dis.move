module 0x4345e440a2ba68d809f9fd16f6fb7e7c08a651eca361d6d10cebb06f7aafdab3::dis {
    struct DIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIS>(arg0, 6, b"DIS", b"Diddy on the SUI", x"4865726520697320746865205061727479206f662044696464792c2077656c636f6d65206775797320212121200a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d0a4f6666696369616c212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8tw_Y_Fo_B2_400x400_9a97a1119b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

