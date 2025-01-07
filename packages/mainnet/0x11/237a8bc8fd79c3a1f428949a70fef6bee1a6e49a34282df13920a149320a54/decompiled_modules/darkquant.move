module 0x11237a8bc8fd79c3a1f428949a70fef6bee1a6e49a34282df13920a149320a54::darkquant {
    struct DARKQUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARKQUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARKQUANT>(arg0, 6, b"DARKQUANT", b"DARK QUANT", b"The dark version of Quant. Quant kid turned to the dark side when he faded $4m on his own coin and instead made 30k, and got doxxed to the whole planet. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/token_0e50b17605.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARKQUANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARKQUANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

