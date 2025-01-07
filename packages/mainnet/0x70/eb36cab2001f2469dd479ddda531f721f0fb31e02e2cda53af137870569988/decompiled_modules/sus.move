module 0x70eb36cab2001f2469dd479ddda531f721f0fb31e02e2cda53af137870569988::sus {
    struct SUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUS>(arg0, 6, b"SUS", b"Suishi", b"Tasty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_96188ca248.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

