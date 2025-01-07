module 0x4ec931ff5cbbc1c288395b5c95b79323c9b63e9c4063acffba01b67c9d5ccb::spike {
    struct SPIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIKE>(arg0, 6, b"SPIKE", b"Spike", b"Spike is Matt Furie's first original drawing from 1984. This goofy, awkward, and friendly dinosaur is going to be the next household name in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spike_2ffd092dd9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

