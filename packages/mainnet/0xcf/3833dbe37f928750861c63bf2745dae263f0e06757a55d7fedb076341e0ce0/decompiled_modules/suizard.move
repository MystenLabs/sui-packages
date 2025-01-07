module 0xcf3833dbe37f928750861c63bf2745dae263f0e06757a55d7fedb076341e0ce0::suizard {
    struct SUIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZARD>(arg0, 6, b"SUIZARD", b"Suizard", b"The magic suizard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3529_d2ffc2f471.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

