module 0x7a0331d5a447ff3941aba782672fb1513804edb8308cd147a290d592cfca256d::dick {
    struct DICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICK>(arg0, 6, b"Dick", b"Dick.", b"Dick is the number one coin in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749389582240.57")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DICK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

