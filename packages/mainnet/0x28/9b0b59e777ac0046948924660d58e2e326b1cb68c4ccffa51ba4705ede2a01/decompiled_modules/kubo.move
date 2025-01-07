module 0x289b0b59e777ac0046948924660d58e2e326b1cb68c4ccffa51ba4705ede2a01::kubo {
    struct KUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUBO>(arg0, 6, b"KUBO", b"Kubo coin", b"Lost in a dream... $kubo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053738_cc8649374d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

