module 0x426d521f7a940882886c021f70d5fb09d5cb114e245fbe47e2d7820527a14b8a::scam {
    struct SCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM>(arg0, 9, b"SCAM", b"REAL SCAM", b"REAL SCAM YOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHojMGX9ApSG1w-W9k7k32Ahs_UklZ_DSZfw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCAM>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

