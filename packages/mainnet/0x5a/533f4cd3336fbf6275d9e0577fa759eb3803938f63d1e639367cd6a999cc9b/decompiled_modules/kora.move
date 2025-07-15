module 0x5a533f4cd3336fbf6275d9e0577fa759eb3803938f63d1e639367cd6a999cc9b::kora {
    struct KORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORA>(arg0, 6, b"KORA", b"Kora community ", b"Group of like minded people from around the world creating generational wealth, lifetime connections and a strong community around crypto leaded by a smart and strong independent FROYO lover ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752587837515.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KORA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

