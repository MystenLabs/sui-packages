module 0xf8667fbe30bbafa8c2281692159fcfec902dd4b0e1fc53944ff963d8ef92f6cb::suinter {
    struct SUINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINTER>(arg0, 6, b"Suinter", b"Sui Winter", b"Brace yourself for the chill of $SUINTER, the frostiest token on the Sui blockchain. Like a cold winter storm, this coin is sweeping in with icy determination. Winter is hereare you ready to weather it with $SUINTER?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suinter_784236aeaa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

