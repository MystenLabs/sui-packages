module 0xb1bb285b7e082d9f29b73e789bd4803d33de5e74430fdd39b98f879e66226612::krabsui {
    struct KRABSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABSUI>(arg0, 6, b"KRABSUI", b"KRABS ON SUI", b"The most original and badass Krabs, made for the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/krabs_500_500_f8c695bd9f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRABSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

