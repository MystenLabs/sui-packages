module 0x23546adcb3b2a31afdd723d8a16e3817d2d3463009a650f5a0af22ddf2ea09c3::rune {
    struct RUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNE>(arg0, 6, b"RUNE", b"SUI RUNE WARRIORS", x"52554e452057415252494f5253202852554e45290a0a416e204149206c6966652073696d756c6174696f6e206f6620612077617272696f72206f6e206120717565737420746f2066696e64207468652052554e452c20746865206375726520666f7220686973206e6174696f6e277320646973656173652e20546865206163636f756e742065766f6c766573206175746f6e6f6d6f75736c792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul55_20241229210800_9dba15ebe3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

