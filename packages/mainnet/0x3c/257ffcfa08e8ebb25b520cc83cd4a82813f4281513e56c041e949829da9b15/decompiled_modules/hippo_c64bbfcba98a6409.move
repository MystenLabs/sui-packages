module 0x3c257ffcfa08e8ebb25b520cc83cd4a82813f4281513e56c041e949829da9b15::hippo_c64bbfcba98a6409 {
    struct HIPPO_C64BBFCBA98A6409 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO_C64BBFCBA98A6409, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO_C64BBFCBA98A6409>(arg0, 0, b"HIPPO", b"HIPPO", b"Pump-style launch token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suigift.fun/api/uploads/token-icons/1788191929592-22bb04ff-376c-4948-9896-44ba4412eb27.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPO_C64BBFCBA98A6409>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HIPPO_C64BBFCBA98A6409>>(0x2::coin::mint<HIPPO_C64BBFCBA98A6409>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO_C64BBFCBA98A6409>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

