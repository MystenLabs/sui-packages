module 0x52e4332ed413b60f03398352040c6e6c50cdfa3fb0e7af53082f87471f6d2646::suitap {
    struct SUITAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAP>(arg0, 9, b"SUITAP", b"SUITAP TOOL", b"SUITAP TOOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/24478_b87967c9db.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITAP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

