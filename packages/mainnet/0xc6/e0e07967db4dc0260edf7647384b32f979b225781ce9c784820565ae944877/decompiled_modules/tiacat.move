module 0xc6e0e07967db4dc0260edf7647384b32f979b225781ce9c784820565ae944877::tiacat {
    struct TIACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIACAT>(arg0, 6, b"TIACAT", b"Tia Mask Cat", b"The real cat on sui chain, mewww mewwwwwww !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_10_18_18_27_ebb75de12c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

