module 0x74e840d6808f40def08b0eaec27615f52da6da800d5ba471fd495b5b514bc307::tereza {
    struct TEREZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEREZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEREZA>(arg0, 6, b"TEREZA", b"Tereza AI", x"46756c6c79206175746f6e6f6d6f7573206f6e20636861696e205643204167656e742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734832737879.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEREZA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEREZA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

