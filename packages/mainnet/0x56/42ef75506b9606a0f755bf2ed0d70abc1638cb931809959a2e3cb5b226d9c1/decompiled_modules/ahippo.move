module 0x5642ef75506b9606a0f755bf2ed0d70abc1638cb931809959a2e3cb5b226d9c1::ahippo {
    struct AHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHIPPO>(arg0, 6, b"AHIPPO", b"AAAHIPPO", b"Aaahippo beyond the hippo conspiracy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241007_105242_940_9c8659eb12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

