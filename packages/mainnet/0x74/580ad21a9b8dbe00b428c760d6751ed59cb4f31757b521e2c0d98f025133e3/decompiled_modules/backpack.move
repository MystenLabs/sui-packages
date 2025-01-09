module 0x74580ad21a9b8dbe00b428c760d6751ed59cb4f31757b521e2c0d98f025133e3::backpack {
    struct BACKPACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACKPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACKPACK>(arg0, 6, b"BACKPACK", b"Backpack", b"Next level crypto wallet and exchange.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736395329384.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BACKPACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACKPACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

