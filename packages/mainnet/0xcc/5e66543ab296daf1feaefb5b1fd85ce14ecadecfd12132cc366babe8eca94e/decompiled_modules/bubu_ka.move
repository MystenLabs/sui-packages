module 0xcc5e66543ab296daf1feaefb5b1fd85ce14ecadecfd12132cc366babe8eca94e::bubu_ka {
    struct BUBU_KA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU_KA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU_KA>(arg0, 9, b"BUBU_KA", b"bubu", b"Bububo niyo, ina nyo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a5e8cb1-d596-4d83-9c50-a17fad302b28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU_KA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBU_KA>>(v1);
    }

    // decompiled from Move bytecode v6
}

