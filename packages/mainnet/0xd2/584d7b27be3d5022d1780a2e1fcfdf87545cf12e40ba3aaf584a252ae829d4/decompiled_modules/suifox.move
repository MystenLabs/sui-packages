module 0xd2584d7b27be3d5022d1780a2e1fcfdf87545cf12e40ba3aaf584a252ae829d4::suifox {
    struct SUIFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFOX>(arg0, 6, b"SUIFOX", b"FOX ON SUI", b"\"The cunning fox $SUIFOX has arrived! Is this the next hit on the Sui blockchain?\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KORSUI_3_db6d227214.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

