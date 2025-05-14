module 0x4ff2031bb33f3b268f077b9838d31bc73703eb08166b0634b6fd34b2cc5498e8::nth {
    struct NTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTH>(arg0, 9, b"nth", b"Lavi", b"jjj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/4572e6d0-30b4-11f0-852e-3585a1f35c1e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTH>>(v1);
        0x2::coin::mint_and_transfer<NTH>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTH>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

