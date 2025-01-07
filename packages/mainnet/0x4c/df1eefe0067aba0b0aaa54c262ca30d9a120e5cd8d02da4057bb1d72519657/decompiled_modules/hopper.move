module 0x4cdf1eefe0067aba0b0aaa54c262ca30d9a120e5cd8d02da4057bb1d72519657::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"HOPPER", b"Hopper on SUI", b"Fck hop.fun. I'm only hop on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971613266.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

