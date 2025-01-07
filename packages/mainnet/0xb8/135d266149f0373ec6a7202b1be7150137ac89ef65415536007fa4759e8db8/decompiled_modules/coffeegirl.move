module 0xb8135d266149f0373ec6a7202b1be7150137ac89ef65415536007fa4759e8db8::coffeegirl {
    struct COFFEEGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFEEGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COFFEEGIRL>(arg0, 6, b"COFFEEGIRL", b"Coffee", b"a monster.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/silence4815_Photo_of_Alice_in_Wonderland_in_steampunk_ar_916_5645a8c2_d517_4fed_b9f0_1a4764cbfff4_bd1eae4a73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COFFEEGIRL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFEEGIRL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

