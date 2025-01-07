module 0x76ec51312c63c43553f2700513928ebc2144235ad4ef4d3f8773cb44a787e1c4::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"SUIJIN", b"SuiJin", b"Suijin is the Shinto god of water in Japanese mythology. The Water Kami is the guardian of the fishing folk, and a patron saint of fertility, motherhood, and easy childbirth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ly_W_d6nl_400x400_1ef459eff0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

