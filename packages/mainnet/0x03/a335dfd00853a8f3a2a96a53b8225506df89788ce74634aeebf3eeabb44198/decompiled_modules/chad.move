module 0x3a335dfd00853a8f3a2a96a53b8225506df89788ce74634aeebf3eeabb44198::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"Chad", b"This Coin For A Chad", x"5468697320436f696e20697320666f722043686164202843484144290a50757265206d656d652c20707572652076696265732c206e6f206e6f6e73656e73652e20434841442069732074686520756c74696d61746520746f6b656e20666f722074686520626f6c642c2074686520666561726c6573732c20616e6420746865206162736f6c757465204368616473206f66207468652063727970746f20776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifbnk6q6zkumpn5kbwqk4io2lwi4gaaoe6agcgy3ss47c6srh7i6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

