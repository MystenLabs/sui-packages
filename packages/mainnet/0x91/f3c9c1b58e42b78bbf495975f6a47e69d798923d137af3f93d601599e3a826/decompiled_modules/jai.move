module 0x91f3c9c1b58e42b78bbf495975f6a47e69d798923d137af3f93d601599e3a826::jai {
    struct JAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAI>(arg0, 6, b"JAI", b"Jimmy Carter AI", b"Presidential Level AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736440469320.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

