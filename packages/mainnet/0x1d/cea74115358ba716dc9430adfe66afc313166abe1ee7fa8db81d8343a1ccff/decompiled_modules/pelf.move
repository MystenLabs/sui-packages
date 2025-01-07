module 0x1dcea74115358ba716dc9430adfe66afc313166abe1ee7fa8db81d8343a1ccff::pelf {
    struct PELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELF>(arg0, 6, b"PELF", b"Fist Sui Pepe Elf", b"Fist Pepe Elf On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_11_ffdfd7b9b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

