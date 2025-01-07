module 0x1a7c746269d72897f5a64b08ea1d13c13206d90ef3cf933c7b4ecc26c91ed466::BABYELON {
    struct BABYELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYELON>(arg0, 9, b"BABYELON", b"SUI BABYELON", b"BABYELON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn5.cdn-telegram.org/file/SLGL_viWpx5G7Uli-yhnHsalC5ISEVL1sN1c3xqmAT0Cmxse4RiIPhGzLyW2xDjge5st3Q1HMt5Yv4X3PFNoinERPZ1VpWxJeLkGHoXzs4WaMbO-_IMg3RGQ8N4hOsxJueQAHS6xk-cSsBmq6f-nEegqnlDOGB9GO1k2ZGSRLcweq7XMNIh3wog0f_eqP0CkVtGcPfCIXKzrGz9tpEHYu1A08QuVZ-NaMrB_6Cxhq6gnhFmMqGkJcOmXheAgknkSCXmwQiEhMNwXX6C3TrkWNWMzNEHJwqNUZTOQkSgSn6Ui7KsxTdPQNBvDWvXB4Wh40nzYR0ITBnTrUGRZkUqvXw.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYELON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABYELON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

