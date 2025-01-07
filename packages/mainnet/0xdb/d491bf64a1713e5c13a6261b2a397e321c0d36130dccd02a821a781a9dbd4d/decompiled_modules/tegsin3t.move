module 0xdbd491bf64a1713e5c13a6261b2a397e321c0d36130dccd02a821a781a9dbd4d::tegsin3t {
    struct TEGSIN3T has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEGSIN3T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEGSIN3T>(arg0, 6, b"TEgsin3t", b"Testign4", b"Test1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732584392902.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEGSIN3T>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEGSIN3T>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

