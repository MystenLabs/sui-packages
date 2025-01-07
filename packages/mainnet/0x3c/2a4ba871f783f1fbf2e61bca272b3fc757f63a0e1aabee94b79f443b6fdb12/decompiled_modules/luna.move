module 0x3c2a4ba871f783f1fbf2e61bca272b3fc757f63a0e1aabee94b79f443b6fdb12::luna {
    struct LUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNA>(arg0, 6, b"LUNA", b"Blue Lexi Luna", b"Mommy Lexi Luna wearing Sui colors to make you bag pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_06_at_21_52_36_3c17edb066.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

