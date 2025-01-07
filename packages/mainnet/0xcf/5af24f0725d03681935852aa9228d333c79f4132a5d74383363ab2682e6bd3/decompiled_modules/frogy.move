module 0xcf5af24f0725d03681935852aa9228d333c79f4132a5d74383363ab2682e6bd3::frogy {
    struct FROGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGY>(arg0, 6, b"Frogy", b"Sui Frogy", b"FROGY leaps from pad to pad, hopping through the Sui water with agility and speed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Frog_869f76338e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

