module 0xcc197006d7d5662e1a204d5f6dced176e3f7682849842b649a275c185a6d6263::yamaha {
    struct YAMAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAMAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAMAHA>(arg0, 9, b"YAMAHA", b"YaMaHa", b"The coin for Luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAMAHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAMAHA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<YAMAHA>>(0x2::coin::mint<YAMAHA>(&mut v2, 4000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

