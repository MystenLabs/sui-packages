module 0x3694ed15e1c8ec9855fb8b193c68fe946d3962b5e840c911469d4c7775d8962c::runpug {
    struct RUNPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNPUG>(arg0, 6, b"RUNPUG", b"PUG THE RUN", b"A PUG THE RUN WHO RUNES THE SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d65386bb163d1c5f5f99492d0b4be79e_3b36a83345.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUNPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

