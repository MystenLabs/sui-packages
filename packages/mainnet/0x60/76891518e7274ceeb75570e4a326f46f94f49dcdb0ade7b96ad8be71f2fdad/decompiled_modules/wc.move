module 0x6076891518e7274ceeb75570e4a326f46f94f49dcdb0ade7b96ad8be71f2fdad::wc {
    struct WC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WC>(arg0, 6, b"WC", b"World Cat", b"https://worldcatcoin.my.canva.site/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rc_M7_Gn_Ob_400x400_b0901a03c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WC>>(v1);
    }

    // decompiled from Move bytecode v6
}

