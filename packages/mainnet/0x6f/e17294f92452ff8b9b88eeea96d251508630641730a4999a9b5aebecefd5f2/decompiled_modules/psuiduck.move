module 0x6fe17294f92452ff8b9b88eeea96d251508630641730a4999a9b5aebecefd5f2::psuiduck {
    struct PSUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUIDUCK>(arg0, 6, b"PSUIDUCK", b"pSuiDuck", b"pSUIiiiduck?? ... pSUUUUIIIIddducccck???!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZY_3i_U7k_400x400_31ed22cc1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

