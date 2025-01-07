module 0x63e09cb2051a5b122635bf22a7cac58059f5e3e6b6963706bcd84940d397c329::catcn {
    struct CATCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCN>(arg0, 9, b"CATCN", b"CATICON", b"A very nice project jump in and buy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22ea4d19-e2af-409e-9ff0-a46eb16a34ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

