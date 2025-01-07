module 0xb27dd31d1655bce307c20b9165402f33a8b7971b08bdc0a45dfc3f0394128d4c::suiggy {
    struct SUIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGGY>(arg0, 6, b"SUIGGY", b"SUIGGY ON SUI", b"The meme coin with so much swag, even your crypto wallet will flex.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/SUIGGYPROFILE_e84a46f98c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

