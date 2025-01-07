module 0xa5f77b9c0093c464ff94866fd8c59f5519449ddada15d8d8d2576cc37a4db6f7::d8nb5gfdfc {
    struct D8NB5GFDFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: D8NB5GFDFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D8NB5GFDFC>(arg0, 9, b"D8NB5GFDFC", b"Monbiz", b"the name of the website i just created", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8310af3-419f-4eb6-b713-eaa6dd9e0475.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D8NB5GFDFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D8NB5GFDFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

