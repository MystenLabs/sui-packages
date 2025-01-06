module 0x6302a1b6fef2c2266de645b84781bad87421e51b1f39713b5ff18c140fc5552e::fm {
    struct FM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FM>(arg0, 6, b"FM", b"Fire Mage by SuiAI", b"Fire Mage brings fire and it BURNS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/WX_20250106_091725_2x_e7305a7bbd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

