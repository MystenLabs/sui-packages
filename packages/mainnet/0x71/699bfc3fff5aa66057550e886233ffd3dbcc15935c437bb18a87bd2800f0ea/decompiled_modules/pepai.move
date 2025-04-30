module 0x71699bfc3fff5aa66057550e886233ffd3dbcc15935c437bb18a87bd2800f0ea::pepai {
    struct PEPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPAI>(arg0, 6, b"PEPAI", b"Pepai", b"Pepai The First Agent on Mars ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/92_97406f95ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

