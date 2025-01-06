module 0xb9a253e0a32c99ffb4709e3246335e9cb372bab74d882ae1c8f4ad96fdd24252::blinky {
    struct BLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKY>(arg0, 6, b"BLINKY", b"Sui Blinky", b"In the fast - paced world of crypto , fortunes are made  in the blink of an eye,that's whete Blinky comes in -a wide-eyed, high-energy frog from sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021423_a7885704e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

