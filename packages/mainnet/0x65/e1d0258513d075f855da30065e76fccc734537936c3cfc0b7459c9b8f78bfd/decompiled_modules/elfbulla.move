module 0x65e1d0258513d075f855da30065e76fccc734537936c3cfc0b7459c9b8f78bfd::elfbulla {
    struct ELFBULLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELFBULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELFBULLA>(arg0, 6, b"ELFBULLA", b"Santa's Elf Hasbulla", b"Like Rudolph, there is one special elf of Santa's can give and do anything for the Sui land prosperity and happiness...it's $ELFBULLA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_101359_656_f53ce5fdce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELFBULLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELFBULLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

