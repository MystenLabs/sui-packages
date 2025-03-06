module 0x929bf7312b0cc4f1900b3d17489762dccd6cc6ac670c070e63237f966b1ff7ea::krasnov {
    struct KRASNOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRASNOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRASNOV>(arg0, 6, b"Krasnov", b"I am Krasnov", x"4920616d20507574696e7320736f636b207075707065740a0a4920616d2061205275737369616e2061737365740a0a49206272696e672066696e616e6369616c2066726565646f6d0a0a4920616d204b7261736e6f7620", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741255951680.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRASNOV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRASNOV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

