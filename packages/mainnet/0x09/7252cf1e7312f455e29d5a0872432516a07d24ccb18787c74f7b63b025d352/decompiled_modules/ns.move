module 0x97252cf1e7312f455e29d5a0872432516a07d24ccb18787c74f7b63b025d352::ns {
    struct NS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NS>(arg0, 6, b"NS", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://token-image.suins.io/icon.svg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NS>>(v2);
    }

    // decompiled from Move bytecode v6
}

