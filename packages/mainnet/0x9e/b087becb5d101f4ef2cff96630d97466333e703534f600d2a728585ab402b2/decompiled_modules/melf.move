module 0x9eb087becb5d101f4ef2cff96630d97466333e703534f600d2a728585ab402b2::melf {
    struct MELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELF>(arg0, 6, b"Melf", b"Mystical Elf", b"Let's pray and Heal The World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bethany_bronwyn_curtis_toon_mystic_elf_d7a944fe1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

