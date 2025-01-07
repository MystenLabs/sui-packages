module 0x766acbfd87464964c19acd4815922d7aa4118c5ecaf3733ca3cfc3aaf9ab3a87::angry {
    struct ANGRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRY>(arg0, 6, b"ANGRY", b"Angry Cat on SUI", b"Angry Cat roars with raw, rebellious energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_649503474_612x612_f56e1e07bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

