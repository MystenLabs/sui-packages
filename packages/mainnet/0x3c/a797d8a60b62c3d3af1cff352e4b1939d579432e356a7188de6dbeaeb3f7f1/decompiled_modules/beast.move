module 0x3ca797d8a60b62c3d3af1cff352e4b1939d579432e356a7188de6dbeaeb3f7f1::beast {
    struct BEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAST>(arg0, 6, b"BEAST", b"$BEAST", b"$BEAST IS NOT COIN A COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755892369507.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

