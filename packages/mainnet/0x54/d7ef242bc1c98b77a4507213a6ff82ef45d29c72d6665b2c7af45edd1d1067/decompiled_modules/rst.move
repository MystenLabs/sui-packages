module 0x54d7ef242bc1c98b77a4507213a6ff82ef45d29c72d6665b2c7af45edd1d1067::rst {
    struct RST has drop {
        dummy_field: bool,
    }

    fun init(arg0: RST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RST>(arg0, 6, b"RST", b"Real Suigger Tate", b"TOP G OF THE DEEP BLUE SEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_08_T222905_700_7e0167e691.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RST>>(v1);
    }

    // decompiled from Move bytecode v6
}

