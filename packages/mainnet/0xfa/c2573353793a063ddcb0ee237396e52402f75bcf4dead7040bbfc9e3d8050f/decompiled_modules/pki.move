module 0xfac2573353793a063ddcb0ee237396e52402f75bcf4dead7040bbfc9e3d8050f::pki {
    struct PKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKI>(arg0, 9, b"PKI", b"PISHI", b"THE CAT AND THE THREE LITTLW HEADS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f20ec86-d30b-445a-b2b7-c6127978bb6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

