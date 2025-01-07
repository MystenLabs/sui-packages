module 0x1fe4324fd2186acc8e5bc54341b3797674049a1a805980eec17b24f7da67f47d::eel {
    struct EEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEL>(arg0, 6, b"Eel", b"Garden eels", x"47617264656e2065656c73206172652067726f7570206c6966652c20616e64207765206b6e6f772065616368206f7468657220766572792077656c6c2c20616e6420696e20746865207669727475616c2063757272656e6379206d61726b65742c207765206e65656420746f206861766520612067726f757020636f6e73656e73757320746f206f776e2074686973206d656d6520636f696e20746f6765746865720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732380449451.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

