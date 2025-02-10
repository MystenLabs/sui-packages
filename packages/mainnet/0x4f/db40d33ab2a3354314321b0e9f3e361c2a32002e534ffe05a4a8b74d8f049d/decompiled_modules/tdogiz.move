module 0x4fdb40d33ab2a3354314321b0e9f3e361c2a32002e534ffe05a4a8b74d8f049d::tdogiz {
    struct TDOGIZ has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: 0x2::coin::Coin<TDOGIZ>) {
        0x2::coin::destroy_zero<TDOGIZ>(arg0);
    }

    fun init(arg0: TDOGIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDOGIZ>(arg0, 6, b"TDOGIZ", b"Test Dogizen", b"Test Dogizen Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dogizen.io/logo.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TDOGIZ>>(0x2::coin::mint<TDOGIZ>(&mut v2, 1000000000000000000, arg1), @0x483173306d8c8a842a8e545ff4715936266fa5f4d7c825959b64e80c05905879);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDOGIZ>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TDOGIZ>>(v2);
    }

    // decompiled from Move bytecode v6
}

