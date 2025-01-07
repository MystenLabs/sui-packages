module 0x69e680e9346a72f9abf8c71ca2754e39923eead240fc9f3e3d9f8964cb62ef37::koko {
    struct KOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKO>(arg0, 6, b"KOKO", b"suikoko", b"Don't bother me,I'm \"KOKO\" now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_21_23_48_17_3023781568.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

