module 0x88319027a292c12e53ce728809a04582113ce89e3faf5efb11d96d4cee4121d8::lion {
    struct LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: LION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LION>(arg0, 6, b"LION", b"Blue Eyed Lion", b"A regal blue-eyed lion. Destined for greatness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lion_01ac71f406.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LION>>(v1);
    }

    // decompiled from Move bytecode v6
}

