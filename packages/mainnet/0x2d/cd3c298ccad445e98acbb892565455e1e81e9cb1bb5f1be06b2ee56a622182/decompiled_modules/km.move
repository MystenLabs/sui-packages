module 0x2dcd3c298ccad445e98acbb892565455e1e81e9cb1bb5f1be06b2ee56a622182::km {
    struct KM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KM>(arg0, 6, b"KM", b"Kekius Maximus", b"Fundius Securious", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735637910135.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

