module 0xf806e2b766905ef46a2fcd14b639d100fafeb53c009449626a68fca031a99c9::b_jod {
    struct B_JOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_JOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_JOD>(arg0, 9, b"bJOD", b"bToken JOD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_JOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_JOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

