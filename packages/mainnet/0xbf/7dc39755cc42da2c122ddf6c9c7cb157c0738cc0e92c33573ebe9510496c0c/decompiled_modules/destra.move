module 0xbf7dc39755cc42da2c122ddf6c9c7cb157c0738cc0e92c33573ebe9510496c0c::destra {
    struct DESTRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESTRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESTRA>(arg0, 6, b"DESTRA", b"Destra Network", x"4275696c64696e67206120446563656e7472616c697a656420576f726c640a0a446573747261204e6574776f726b206f66666572732061206f6e652d7374657020736f6c7574696f6e20666f7220616c6c20796f757220446550494e2c20436c6f756420616e6420414920636f6d707574696e67206e656564732e0a0a57656273697465202d20687474703a2f2f6465737472612e6e6574776f726b0a506f7274616c202d2068747470733a2f2f742e6d652f6465737472614e6574776f726b0a54776974746572202d20687474703a2f2f782e636f6d2f4465737472614e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul70_20250107215701_ecaa16fa3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESTRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DESTRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

