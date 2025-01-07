module 0xfcecbc18e6a5a9f32b45253af989bd82865b50897addcb9d4e1463cd4a7310f4::muttley {
    struct MUTTLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTTLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTTLEY>(arg0, 6, b"Muttley", b"MuttleyDog", b"MuttleyDOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731751243753.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUTTLEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTTLEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

