module 0x448ef5569bae7d4adaa41428d367f5a1a2d5160f5c94c872da2f3014920250ea::ns {
    struct NS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NS>(arg0, 6, b"NS", b"All Hail Sui", b"All hail sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731460152523.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

