module 0xf5aa3cfb5c4092e6390e7ad9a85d692a282f114d95a86d806709be1fdbd0b694::simonscat {
    struct SIMONSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMONSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMONSCAT>(arg0, 6, b"SimonsCat", b"Simon's cat On Sui", b"Simon's Cat is a British animated web and book series written by Simon Tofield. It features a fat, hungry white cat who uses various tactics to get his owner to feed him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/channels4_profile_f45127e014.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMONSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMONSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

