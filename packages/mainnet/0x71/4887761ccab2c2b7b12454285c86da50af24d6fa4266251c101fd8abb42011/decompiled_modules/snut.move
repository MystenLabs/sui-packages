module 0x714887761ccab2c2b7b12454285c86da50af24d6fa4266251c101fd8abb42011::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 9, b"Snut", b"Snut-Arc on sui", b"Lfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/24cf07e0138c90260f884d0e90a9d1a3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

