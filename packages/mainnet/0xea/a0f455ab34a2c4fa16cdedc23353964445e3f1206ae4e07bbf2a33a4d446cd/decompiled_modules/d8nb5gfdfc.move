module 0xeaa0f455ab34a2c4fa16cdedc23353964445e3f1206ae4e07bbf2a33a4d446cd::d8nb5gfdfc {
    struct D8NB5GFDFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: D8NB5GFDFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D8NB5GFDFC>(arg0, 9, b"D8NB5GFDFC", b"Monbiz", b"the name of the website i just created", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff1611cd-c789-400e-8fab-dcac047d6a67.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D8NB5GFDFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D8NB5GFDFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

