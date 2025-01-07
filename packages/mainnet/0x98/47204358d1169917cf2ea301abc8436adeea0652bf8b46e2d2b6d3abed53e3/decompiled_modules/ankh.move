module 0x9847204358d1169917cf2ea301abc8436adeea0652bf8b46e2d2b6d3abed53e3::ankh {
    struct ANKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANKH>(arg0, 6, b"ANKH", b"THe ankh", b"The ankh is a symbol originating in ancient Egypt. It is also known as the key of life or key of the Nile and can symbolize both life and life after death. BRINGING NEW LIFE TO SUI MEMES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ankh_astrology_e34e138fd4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

