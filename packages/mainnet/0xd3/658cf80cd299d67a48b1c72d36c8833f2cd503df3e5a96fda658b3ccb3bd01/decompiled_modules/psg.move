module 0xd3658cf80cd299d67a48b1c72d36c8833f2cd503df3e5a96fda658b3ccb3bd01::psg {
    struct PSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSG>(arg0, 6, b"PSG", b"PYSGRA", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731192691011.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

