module 0x67469da4a7eeb512f2c26a003dc82f12dbdefa4313c178b93ba341089e390aaf::cgm {
    struct CGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGM>(arg0, 9, b"CGM", b"corruption grift machine", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQhRtwd5Jc64bgkJ18AkyMPJen4CipDwHXNuLsZsMnSzZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CGM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

