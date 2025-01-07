module 0x3132e862a1542dc5e92968f0bfbbe45bfd9aae26d902af8afcde58b81a1e3257::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 9, b"BLUE", b"Bluefin", b"BLUE is the native token of Bluefin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/square.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUE>>(0x2::coin::mint<BLUE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUE>>(v2);
    }

    // decompiled from Move bytecode v6
}

