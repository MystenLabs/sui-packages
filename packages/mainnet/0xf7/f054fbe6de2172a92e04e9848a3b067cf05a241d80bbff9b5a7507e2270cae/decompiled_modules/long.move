module 0xf7f054fbe6de2172a92e04e9848a3b067cf05a241d80bbff9b5a7507e2270cae::long {
    struct LONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONG>(arg0, 6, b"LONG", b"LONG SUI", b"Mascot 2024 Long Sui coming Sui Net Work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a18334e1584a412606f78f71c557e5ee_90d99d8a95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

