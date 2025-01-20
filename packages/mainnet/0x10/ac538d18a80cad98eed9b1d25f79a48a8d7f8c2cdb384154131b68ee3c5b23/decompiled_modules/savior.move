module 0x10ac538d18a80cad98eed9b1d25f79a48a8d7f8c2cdb384154131b68ee3c5b23::savior {
    struct SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVIOR>(arg0, 9, b"SAVIOR", b"OFFICIAL SAVIOR", b"The savior of our bags, the one and only Donald Trump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdBvz9nggNujGHdjdPtsiAEDH1kXzghqhcqxqb7TVSdh2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAVIOR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAVIOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVIOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

