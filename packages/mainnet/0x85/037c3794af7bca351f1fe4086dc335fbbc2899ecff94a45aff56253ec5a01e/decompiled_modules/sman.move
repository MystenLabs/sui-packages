module 0x85037c3794af7bca351f1fe4086dc335fbbc2899ecff94a45aff56253ec5a01e::sman {
    struct SMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAN>(arg0, 6, b"SMAN", b"SUI MAN", b"Do you honestly think that you won't get any stronger for the rest of your life? Instead of sitting around frustrated, it's better to keep on moving forward.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730999870951.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

