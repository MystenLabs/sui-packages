module 0x8e07964b81c7eb57f13e4406d6b0cbc845fcd82e133dc900f414544a28f97886::brain {
    struct BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIN>(arg0, 6, b"BRAIN", b"BRAIN SUI", b"$BRAIN is here to protect the BRAIN on Earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_30_21_51_33_46596e43c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

