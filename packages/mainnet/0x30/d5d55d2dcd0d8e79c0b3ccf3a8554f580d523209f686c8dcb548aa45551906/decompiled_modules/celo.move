module 0x30d5d55d2dcd0d8e79c0b3ccf3a8554f580d523209f686c8dcb548aa45551906::celo {
    struct CELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CELO>(arg0, 9, b"CELO", b"Celo Coin", b"Help Celo to get bigger (he is 5' 1\")", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2776b8b01c07981c724909adbeb9237eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CELO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CELO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

