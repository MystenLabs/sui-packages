module 0xab64689fa27d6c290be1c3216a7f5ce75134e772364b08923ce976d5e5a0ecee::biden {
    struct BIDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIDEN>(arg0, 6, b"Biden", b"biden", b"The man ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750391195906.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIDEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIDEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

