module 0xb9f32b61a4322e6174a60d57db961a4aa16f33f706c2dec1336643d00cf97683::ppt {
    struct PPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PPT>(arg0, 6, b"PPT", b"PEPETO by SuiAI", b"Just a King Of Pepe created by AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/9_Ws887b1_400x400_caaae5df71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PPT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

