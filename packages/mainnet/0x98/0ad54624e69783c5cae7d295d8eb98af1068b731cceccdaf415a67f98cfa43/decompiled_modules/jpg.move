module 0x980ad54624e69783c5cae7d295d8eb98af1068b731cceccdaf415a67f98cfa43::jpg {
    struct JPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPG>(arg0, 9, b"JPG", b"Stp", b"STP is a productive coin that'll do well in posterity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5433ee8-8634-4a9f-bb1d-83e40cdee5d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

