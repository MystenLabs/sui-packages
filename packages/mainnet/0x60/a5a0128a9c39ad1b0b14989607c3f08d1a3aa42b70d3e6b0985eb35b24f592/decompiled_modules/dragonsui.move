module 0x60a5a0128a9c39ad1b0b14989607c3f08d1a3aa42b70d3e6b0985eb35b24f592::dragonsui {
    struct DRAGONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGONSUI>(arg0, 6, b"DRAGONSUI", b"SUIDRAGON", b"Harness the fiery power of the dragon as we conquer new horizons on $SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_9a980a2c5f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

