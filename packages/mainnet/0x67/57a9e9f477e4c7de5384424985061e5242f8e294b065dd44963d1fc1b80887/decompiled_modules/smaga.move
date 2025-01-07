module 0x6757a9e9f477e4c7de5384424985061e5242f8e294b065dd44963d1fc1b80887::smaga {
    struct SMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAGA>(arg0, 6, b"SMaga", b"Sui Maga", b"Meme Maga in sui, create only for fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003068_d6600b2adf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

