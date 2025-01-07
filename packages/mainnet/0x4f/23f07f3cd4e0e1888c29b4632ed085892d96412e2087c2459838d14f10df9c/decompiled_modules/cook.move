module 0x4f23f07f3cd4e0e1888c29b4632ed085892d96412e2087c2459838d14f10df9c::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 9, b"COOK", b"The Ultimate Cook", b"The Ultimate Cook is here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS3DdrSjPNaQXD3QmDCTvoq1eZwFqSNC8aukvyVVYry8X")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COOK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

