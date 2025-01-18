module 0xfb9e1f32f88b508f3807b9bc28f0db1bf791e1366aa833d070f26c0f428520ca::america {
    struct AMERICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMERICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMERICA>(arg0, 6, b"AMERICA", b"America Reboot", b"$AMERICA: With Musk, Bezos & Zuckerberg at the POTUS inauguration, the movement is unstoppable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737160629607.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMERICA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMERICA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

