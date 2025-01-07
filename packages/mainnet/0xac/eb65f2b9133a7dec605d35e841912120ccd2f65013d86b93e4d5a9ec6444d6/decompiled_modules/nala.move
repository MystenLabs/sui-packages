module 0xaceb65f2b9133a7dec605d35e841912120ccd2f65013d86b93e4d5a9ec6444d6::nala {
    struct NALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALA>(arg0, 6, b"NALA", b"Raoul Pal's Dog", b"Nala is Raoul Pal's loyal companion. Her playful antics have made her an irreplaceable part of Raoul's journey, both personally and professionally.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_23_193904_dccbc937f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

