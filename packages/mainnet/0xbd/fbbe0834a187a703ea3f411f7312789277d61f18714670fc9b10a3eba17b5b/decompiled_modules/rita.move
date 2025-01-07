module 0xbdfbbe0834a187a703ea3f411f7312789277d61f18714670fc9b10a3eba17b5b::rita {
    struct RITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RITA>(arg0, 6, b"RITA", b"Sui Rita", b"Im Sui Rita and Im a fatherless rat. Funny enough? Or should I tell you how I got dumped by my mother when I was 4? Enough talking, lets get rattling.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_05_23_T224949_870_7b661dfa35.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

