module 0xf4a29d311cbc580135035e706c794410ff972a5e63e1aa1a5efa2625bd17a1db::brickbros {
    struct BRICKBROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRICKBROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRICKBROS>(arg0, 6, b"BRICKBROS", b"BrickBrosSUI", x"425249434b20627920425249434b2077652073656520726573756c74730a425249434b2042524f532e206573742e2031393835", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CEIB_Ic4_Z_400x400_04927ea62a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRICKBROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRICKBROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

