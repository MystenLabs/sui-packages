module 0x9a572f94ca9df98b61c335ff9a2a9d6152406e28bfc377227488322d87d836e0::ken {
    struct KEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KEN>(arg0, 6, b"KEN", b"k25 by SuiAI", b"Hmmm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/worldboss_b0ce39ee00.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

