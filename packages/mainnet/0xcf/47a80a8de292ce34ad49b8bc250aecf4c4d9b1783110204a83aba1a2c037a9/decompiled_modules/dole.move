module 0xcf47a80a8de292ce34ad49b8bc250aecf4c4d9b1783110204a83aba1a2c037a9::dole {
    struct DOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLE>(arg0, 9, b"DOLE", b"Doleee", b"Tat ca tai Doleeeeeeeeeeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6f4f0a9498fde7ca62e9c9c6e5082fabblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

