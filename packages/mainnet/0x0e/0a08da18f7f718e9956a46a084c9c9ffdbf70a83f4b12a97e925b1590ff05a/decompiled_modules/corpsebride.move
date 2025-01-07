module 0xe0a08da18f7f718e9956a46a084c9c9ffdbf70a83f4b12a97e925b1590ff05a::corpsebride {
    struct CORPSEBRIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORPSEBRIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORPSEBRIDE>(arg0, 6, b"CORPSEBRIDE", b"Corpse Bride", b"Till death and beyond do us part! Corpse Bride on Sui brings a gothic charm straight out of the underworld.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Corpse_Bride_53e497f38d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORPSEBRIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORPSEBRIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

