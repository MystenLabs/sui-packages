module 0x7c577b435a38e008eec5c8975d8cc446dc2b91997f1cb1653370f8c219e2410::shartcoin {
    struct SHARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARTCOIN>(arg0, 6, b"Shartcoin", b"WET FARTCOIN", x"41202277657420666172742220697320636f6d6d6f6e6c79206b6e6f776e206173206120227368617274222e2054686973207465726d2072656665727320746f206120736974756174696f6e207768657265207761746572792073746f6f6c2069732072656c6561736564207768696c652070617373696e67206761730a0a414c534f205355492049532057415920424554544552205448414e20534f4c0a4c657420746865205375706572696f7220636861696e20666c69702074686520747261736820736f6c2066617274636f696e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747411327954.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARTCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

