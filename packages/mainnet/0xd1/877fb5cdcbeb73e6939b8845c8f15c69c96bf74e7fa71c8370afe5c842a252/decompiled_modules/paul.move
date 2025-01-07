module 0xd1877fb5cdcbeb73e6939b8845c8f15c69c96bf74e7fa71c8370afe5c842a252::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAUL>(arg0, 6, b"PAUL", b"Paul", b"$PAUL the Sui's  Meme Penguin JOIN THE MOVEMENT #FlipThePengu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734562102983.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

