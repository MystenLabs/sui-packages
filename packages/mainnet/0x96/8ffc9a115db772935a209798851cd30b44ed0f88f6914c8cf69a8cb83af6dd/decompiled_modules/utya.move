module 0x968ffc9a115db772935a209798851cd30b44ed0f88f6914c8cf69a8cb83af6dd::utya {
    struct UTYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTYA>(arg0, 6, b"UTYA", b"suiutya", b"$SUI $UTYA isn't just another memecoin. It's a movement driven by community, spreading joy and positivity through the iconic Duck Emoji.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suita_430cfc9559.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UTYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

