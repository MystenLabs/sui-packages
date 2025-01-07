module 0xf79619edac33bc7a77278d65748b31681d90fb680f5317cb0764b920d7dc56::sauron {
    struct SAURON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAURON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAURON>(arg0, 6, b"SAURON", b"sauron", b"I am your only future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PXX_6_LP_Ya_400x400_bd1a95c2dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAURON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAURON>>(v1);
    }

    // decompiled from Move bytecode v6
}

