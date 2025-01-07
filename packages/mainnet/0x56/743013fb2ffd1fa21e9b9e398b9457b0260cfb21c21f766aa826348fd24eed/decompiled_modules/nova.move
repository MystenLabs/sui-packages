module 0x56743013fb2ffd1fa21e9b9e398b9457b0260cfb21c21f766aa826348fd24eed::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"First AI President", b"Nova is the world's first artificial intelligence to hold the office of President. Developed by a coalition of leading tech companies and government agencies, Nova was designed to bring unparalleled efficiency, data-driven decision-making, and unbiased governance to the highest office. With advanced machine learning algorithms and access to vast amounts of data, Nova can analyze complex issues, predict outcomes, and propose innovative solutions to national and global challenges.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1vr_QI_9x_I_400x400_ba8059fe1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

