module 0xca6b5c9eba2d8ac5bcc4f4af325cdbd918a9917b94ed260edc2cf5697a297852::kcat {
    struct KCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCAT>(arg0, 6, b"KCAT", b"KOI CAT", b"I'll swim and meow meow and moon moon moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3697_e07855d310.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

