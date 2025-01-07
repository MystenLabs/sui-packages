module 0x583c31864bd80d534b90d2d8b659c114b63fbce0a82597d8c938e5d2e93c30db::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"God", b"SuiGod", x"54656c656772616d2063726561746564206174203530306b0a547769747465722063726561746564206174203530306b200a537569204169722064726f707320666f7220746f7020686f6c64657273203530306b0a436f6d6d756e6974792061697264726f7073203530306b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047337_5007513052.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

