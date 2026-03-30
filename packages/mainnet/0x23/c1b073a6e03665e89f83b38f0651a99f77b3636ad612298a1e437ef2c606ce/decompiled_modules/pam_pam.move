module 0x23c1b073a6e03665e89f83b38f0651a99f77b3636ad612298a1e437ef2c606ce::pam_pam {
    struct PAM_PAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAM_PAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAM_PAM>(arg0, 6, b"Pam pam", b"Pamyeuoi1", b"De thuong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib3bk6qldm73iuyzjzcojnac4huxzp5e26h45lfivj777otucp4ju")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAM_PAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAM_PAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

