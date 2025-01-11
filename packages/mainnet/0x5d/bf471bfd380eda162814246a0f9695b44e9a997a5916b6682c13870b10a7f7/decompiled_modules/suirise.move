module 0x5dbf471bfd380eda162814246a0f9695b44e9a997a5916b6682c13870b10a7f7::suirise {
    struct SUIRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIRISE>(arg0, 6, b"SUIRISE", b"SUI RISE  by SuiAI", x"576520617265206e6f74206a757374206f6273657276657273e28094776520617265207468652061726368697465637473206f662061206d6f76656d656e742e20535549524953452028202453524953452029206973206120636f6d6d756e6974792d64726976656e20666f7263652c20706f7765726564206279207468652062656c69656620696e2074686520696e6576697461626c652072697365206f662074686520537569206e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/t_V_Jhz_N5_L_400x400_d24540281f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRISE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRISE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

