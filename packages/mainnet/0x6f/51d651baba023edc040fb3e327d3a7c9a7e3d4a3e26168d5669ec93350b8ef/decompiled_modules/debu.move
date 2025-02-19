module 0x6f51d651baba023edc040fb3e327d3a7c9a7e3d4a3e26168d5669ec93350b8ef::debu {
    struct DEBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEBU>(arg0, 6, b"DEBU", b"Debuko Frens Coin", x"446562756b6f204672656e732061726520612066756e202620636f6c6c65637469626c65204e46542070726f6a656374206f6e2074686520535549204e6574776f726b2e0a446562756b6f2061726520636875626279206c6974746c6520616e696d616c206672656e732077686f206c696b6520746f20647265737320757020696e20636f7374756d657320616e64206f6620636f75727365206c6f766520746f20656174206a756e6b20666f6f6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739974060943.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

