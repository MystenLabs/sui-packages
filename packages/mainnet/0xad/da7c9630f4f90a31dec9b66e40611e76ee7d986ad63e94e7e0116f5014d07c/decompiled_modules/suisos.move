module 0xadda7c9630f4f90a31dec9b66e40611e76ee7d986ad63e94e7e0116f5014d07c::suisos {
    struct SUISOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISOS>(arg0, 6, b"Suisos", b"SuiSOS Coin", b"The #SuiSOS Crypto  project is designed and implemented to support endangered animals, especially the Asiatic cheetah.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifx6qw5x55klscficarpqwnd645dkfj6z2vgbjrxy2grgf6x5wkqq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

