module 0xd47373da235b35f4a48630e086b8cca6763fc720c2c0d751fabd096697a86d77::rawegg {
    struct RAWEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAWEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAWEGG>(arg0, 6, b"RAWEGG", b"Sui Rawegg", b"Let's go Cooking me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062282_ce76e6c5e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAWEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAWEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

