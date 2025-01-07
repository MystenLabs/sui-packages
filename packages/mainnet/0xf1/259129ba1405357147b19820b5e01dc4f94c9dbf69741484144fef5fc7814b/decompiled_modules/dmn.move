module 0xf1259129ba1405357147b19820b5e01dc4f94c9dbf69741484144fef5fc7814b::dmn {
    struct DMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMN>(arg0, 9, b"DMN", b"Damon", b"LET'S GO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a334d872-6302-4a48-884c-d3cc0a6549d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

