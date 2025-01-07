module 0x6cd743b73f74759c8bd1ea3accaac89a6fa7690e150ae233f4fafff69972dc4d::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCAT>(arg0, 6, b"POPCAT", b"Popcat on Sui", b"The cat pops", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/it2_VZH_Lf_400x400_1d357c224c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

