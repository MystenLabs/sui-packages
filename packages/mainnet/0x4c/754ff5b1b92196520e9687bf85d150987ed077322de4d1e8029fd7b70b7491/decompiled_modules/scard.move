module 0x4c754ff5b1b92196520e9687bf85d150987ed077322de4d1e8029fd7b70b7491::scard {
    struct SCARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARD>(arg0, 6, b"SCARD", b"Sui Magic Card", b"a mysterious and magical card born on Sui network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951900315.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

