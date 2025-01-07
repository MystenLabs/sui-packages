module 0x9ed6ef3530069f5253086652c8b3b52da48fef3f40b09dcbda491065e1fe6efb::danke {
    struct DANKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANKE>(arg0, 6, b"DANKE", b"THANK YOU", b"0xe613bd9c2799fb0079272064fbda8120cd81a94b4b76c9bf72a6c8b07fe6b7cf thanks for everything brother, have a nice day hope the wake up was good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wakeup_2081cf1aa1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

