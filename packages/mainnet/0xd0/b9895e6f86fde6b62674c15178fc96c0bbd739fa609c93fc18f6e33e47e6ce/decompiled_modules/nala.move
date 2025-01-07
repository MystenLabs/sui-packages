module 0xd0b9895e6f86fde6b62674c15178fc96c0bbd739fa609c93fc18f6e33e47e6ce::nala {
    struct NALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALA>(arg0, 6, b"NALA", b"Nala the Lion", b"I'm a CUTE  baby lion from Africa!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TIGER_19_30b6dfd15a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

