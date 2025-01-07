module 0xcd53576ff2d898797f4418af45a8898e5c880d22ade61d408df26acbb2d295e9::piran {
    struct PIRAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRAN>(arg0, 6, b"PIRAN", b"Piran Hypeee", x"4120467265616b696e67204e61756768747920506972616e686120696e2074686520537569204f6365616e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DBCS_9_HY_400x400_121623d046.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

