module 0x60e27a7cc5fbb71cc6d4e0bab5cf1d52d0d91f2c6361b868a0c357d673741ea2::lucky {
    struct LUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY>(arg0, 6, b"LUCKY", b"LUCKY FISH", b"Give a man a fish and you feed him for a day; teach a man to fish and you feed him for a lifetime.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lucky_Fish_e168c308cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

