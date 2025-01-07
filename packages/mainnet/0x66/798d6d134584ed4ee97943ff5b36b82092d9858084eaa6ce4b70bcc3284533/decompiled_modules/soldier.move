module 0x66798d6d134584ed4ee97943ff5b36b82092d9858084eaa6ce4b70bcc3284533::soldier {
    struct SOLDIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLDIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLDIER>(arg0, 6, b"Soldier", b"Winter Soldier", b"The Winter Soldier is a member of the Avengers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954974699.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLDIER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLDIER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

