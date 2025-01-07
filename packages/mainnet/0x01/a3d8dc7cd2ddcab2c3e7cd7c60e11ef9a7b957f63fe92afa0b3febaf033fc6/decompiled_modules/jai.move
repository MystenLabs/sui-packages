module 0x1a3d8dc7cd2ddcab2c3e7cd7c60e11ef9a7b957f63fe92afa0b3febaf033fc6::jai {
    struct JAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAI>(arg0, 6, b"JAI", b"Jelly AI", b"74 101 108 108 121 65 105", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731007475544.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

