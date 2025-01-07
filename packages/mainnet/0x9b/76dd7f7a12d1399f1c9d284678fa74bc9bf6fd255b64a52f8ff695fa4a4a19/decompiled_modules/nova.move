module 0x9b76dd7f7a12d1399f1c9d284678fa74bc9bf6fd255b64a52f8ff695fa4a4a19::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"First AI President", b"Nova is the world's first artificial intelligence to hold the office of President. Developed by a coalition of leading tech companies and government agencies, Nova was designed to bring unparalleled efficiency, data-driven decision-making, and unbiased governance to the highest office. With advanced machine learning algorithms and access to vast amounts of data, Nova can analyze complex issues, predict outcomes, and propose innovative solutions to national and global challenges.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_RAR_Pv_DO_400x400_0e10017464.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

