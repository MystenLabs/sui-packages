module 0xaf2a2e62dd038051848363c6c2034df1784c62a8c54424eb52fc02fccf190045::ratasui {
    struct RATASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATASUI>(arg0, 6, b"RATASUI", b"RataSUI of SUI", b"RataSui \"The CHEF of Sui Chain\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ratasui_b58010935b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

