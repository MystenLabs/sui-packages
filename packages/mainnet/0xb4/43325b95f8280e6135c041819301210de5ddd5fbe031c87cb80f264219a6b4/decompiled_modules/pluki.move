module 0xb443325b95f8280e6135c041819301210de5ddd5fbe031c87cb80f264219a6b4::pluki {
    struct PLUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUKI>(arg0, 6, b"PLUKI", b"Pluki", b"Pluki - the one and only chick in the whole universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_09_16_T201428_175_164b297c69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

