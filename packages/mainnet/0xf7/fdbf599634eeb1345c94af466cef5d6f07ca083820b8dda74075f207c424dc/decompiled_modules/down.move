module 0xf7fdbf599634eeb1345c94af466cef5d6f07ca083820b8dda74075f207c424dc::down {
    struct DOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWN>(arg0, 6, b"DOWN", b"Poseidown", b"The undisputed king of the degen seas, ruling the Sui oceans like a tard boss.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capa_11_copia_2_3b74824782.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

