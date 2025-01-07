module 0x139252f250fd0338bc088759480253bd5196b9b63cae5674c30d8893154ff7b0::wusdc {
    struct WUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUSDC>(arg0, 6, b"WUSDC", b"USDC", b"Testing a new coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2575_eda9c32113.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

