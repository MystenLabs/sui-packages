module 0x6e5c16372c7797476c2f45528149570adac9bcea747ed132b4a6e9310def635::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCAT>(arg0, 6, b"Fcat", b"FatCat", b"A cat is looking at you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000277056.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

