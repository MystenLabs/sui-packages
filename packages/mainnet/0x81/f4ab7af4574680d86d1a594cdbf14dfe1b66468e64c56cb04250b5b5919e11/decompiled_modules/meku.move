module 0x81f4ab7af4574680d86d1a594cdbf14dfe1b66468e64c56cb04250b5b5919e11::meku {
    struct MEKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEKU>(arg0, 6, b"MEKU", b"MEku", b"Meku sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240914003653_efbe8d55a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

