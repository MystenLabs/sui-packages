module 0x140007bc19948179faa8328c39b648f367ce3111b349702e78645ff7e5f26e00::hellon {
    struct HELLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLON>(arg0, 9, b"hello1", b"hellon", b"hello here ghjhghjg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/834b03b5-26cf-417d-95ab-3cb85db610f5.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

