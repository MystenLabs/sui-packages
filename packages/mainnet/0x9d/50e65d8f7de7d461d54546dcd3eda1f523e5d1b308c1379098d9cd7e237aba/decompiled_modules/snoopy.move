module 0x9d50e65d8f7de7d461d54546dcd3eda1f523e5d1b308c1379098d9cd7e237aba::snoopy {
    struct SNOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOPY>(arg0, 6, b"SNOOPY", b"Beagle Snoopy", b"The lovable rascal who sniffs out adventures, chases dreams, and always ends up stealing the snacks, because lifes too short not to be a little mischievous!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_11_18_47_07_f18eadcbf4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

