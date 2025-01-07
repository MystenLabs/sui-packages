module 0xe97eb4e47ae5582d7b94c44e67d51e67efc435fe00d5b14b0a33725c190fa2f0::kirbysui {
    struct KIRBYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBYSUI>(arg0, 6, b"KirbySui", b"Kirby Sui", b"Kirby Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Dy_Fnuca_QA_Ae_MJF_4c242e9cbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRBYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

