module 0x290b818d85e5c144dd5ed891a7532f433f29b249d91d5492cc0cf8cf9d744fd4::stn {
    struct STN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STN>(arg0, 9, b"STN", b"spontaneou", x"616e6f74686572206f6e652061626f75742073706f6e74616e656f75636f696e0a456d62726163652074686520756e657870656374656420776974682053706f6e74616e656f75436f696e3a205468652064796e616d69632063727970746f63757272656e63792074686174277320616c776179732066756c6c206f66207375727072697365732c2064656c69766572696e6720737075722d6f662d7468652d6d6f6d656e742070726f6669747320616e64206578636974696e6720747769737473206174206576657279207475726e2120f09f8c9ff09f92b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/769935d4-6684-49ad-b537-befe903eb762.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STN>>(v1);
    }

    // decompiled from Move bytecode v6
}

