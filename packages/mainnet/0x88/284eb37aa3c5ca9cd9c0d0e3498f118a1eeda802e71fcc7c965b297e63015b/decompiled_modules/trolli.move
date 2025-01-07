module 0x88284eb37aa3c5ca9cd9c0d0e3498f118a1eeda802e71fcc7c965b297e63015b::trolli {
    struct TROLLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLI>(arg0, 6, b"TROLLI", b"TROLLI on SUI", x"54726f6c6c692069732036697839696e65277320646f6720696e207265616c206c6966652c20616e642061206d656d65636f696e207468617427732061626f757420746f207368616b652075702063727970746f20776974682061206261726b20616e64206120626974652120f09f90b620496e2074686520776f726c64206f662054726f6c6c692c20657665727920646179206973206120677265656e206461792c206e696767612120f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732445494184.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

