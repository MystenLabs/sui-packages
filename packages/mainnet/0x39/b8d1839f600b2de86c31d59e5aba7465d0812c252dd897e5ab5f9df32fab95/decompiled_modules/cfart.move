module 0x39b8d1839f600b2de86c31d59e5aba7465d0812c252dd897e5ab5f9df32fab95::cfart {
    struct CFART has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFART>(arg0, 6, b"CFART", b"CRONJE FART", b"Croenje Fart Aura is the ultimate power move energy that radiates self-acceptance and humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiepmbsxttmk7rivgfvsbq5dsydqidgoj7g5rynpljz3umfjluhn6m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CFART>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

