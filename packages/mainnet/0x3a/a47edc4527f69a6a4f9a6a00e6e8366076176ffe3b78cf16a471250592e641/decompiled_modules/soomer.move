module 0x3aa47edc4527f69a6a4f9a6a00e6e8366076176ffe3b78cf16a471250592e641::soomer {
    struct SOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOMER>(arg0, 6, b"SOOMER", b"SOOMER on SUI", b"just me SOOMER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/st1_2_804x1024_ecb1334d30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

