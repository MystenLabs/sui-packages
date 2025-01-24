module 0xc7d42fe27cf9942874607f68399235fe6488138786eb6ac0bc3e14c0e93f334::murad {
    struct MURAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURAD>(arg0, 9, b"Murad", b"Murad On Sui", b"The Crypto President", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdWq3yW1TUXrmTx8idfqQVesXWoRDPcvviRQKQWH9zbsr")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MURAD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MURAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURAD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

