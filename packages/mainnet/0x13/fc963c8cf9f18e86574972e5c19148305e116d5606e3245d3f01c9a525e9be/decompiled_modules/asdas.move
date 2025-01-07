module 0x13fc963c8cf9f18e86574972e5c19148305e116d5606e3245d3f01c9a525e9be::asdas {
    struct ASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDAS>(arg0, 9, b"ASDAS", b"fgfg", b"DGFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffa313ae-02d7-4a92-8d90-2be5d822d6f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

