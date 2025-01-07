module 0x459e172f9e8e4da17650e0cad1127fc2b36115364341dc569203954858f5330e::suikoko {
    struct SUIKOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOKO>(arg0, 8, b"KOKO", b"SUI KOKO", b"Don't bother me,I'm KOKO now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F2024_10_21_23_48_17_33c64a7c6a.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKOKO>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKOKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOKO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

