module 0xc292167efdd513c058c019532f7491f1499779309eacf3aeeabed5523462b04e::sgpt {
    struct SGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGPT>(arg0, 6, b"SGPT", b"SUIGPT", b"Through tailored Prompt Engineering, SuiGPT empowers GPT-4 to be proficient in the Move language, enabling it to generate corresponding Move code based on user instructions. It can be used through the GPTutor interface, and its API to get Prompt by user instruction is available on the Web. The website version is coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_27_19_10_51_a3bb74a22b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

