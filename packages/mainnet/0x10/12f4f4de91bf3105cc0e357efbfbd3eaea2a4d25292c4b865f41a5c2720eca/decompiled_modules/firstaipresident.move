module 0x1012f4f4de91bf3105cc0e357efbfbd3eaea2a4d25292c4b865f41a5c2720eca::firstaipresident {
    struct FIRSTAIPRESIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRSTAIPRESIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRSTAIPRESIDENT>(arg0, 6, b"FirstAIPresident", b"NOVA", b"Nova is the world's first artificial intelligence to hold the office of President. Developed by a coalition of leading tech companies and government agencies, Nova was designed to bring unparalleled efficiency, data-driven decision-making, and unbiased governance to the highest office. With advanced machine learning algorithms and access to vast amounts of data, Nova can analyze complex issues, predict outcomes, and propose innovative solutions to national and global challenges.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_C53_FF_09_F5_D5_4_A2_B_923_F_1264_D8_D6_E7_DE_0e5c8cf28c_92e5fb6d1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRSTAIPRESIDENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIRSTAIPRESIDENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

