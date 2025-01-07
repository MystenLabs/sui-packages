module 0x6204a92ce7c01d68acf78f4bdff1818bea57c6f06f0d14086a190abb6e453383::wol {
    struct WOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOL>(arg0, 9, b"WOL", b"WOLRUS", x"24574f4c525553202d206d656d65636f696e20696e7370697265642062792066617420616e642068617070792077616c72757365732120576520646f6e27742073746f726520796f75722066696c65732c2077652073746f726520796f7572206d656d65732e204a6f696e206f757220726f6f6b657279206f6e207468652069636520666c6f652120f09fa6ad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3a7ab9593551061e5c99d872dd4c2d2eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

