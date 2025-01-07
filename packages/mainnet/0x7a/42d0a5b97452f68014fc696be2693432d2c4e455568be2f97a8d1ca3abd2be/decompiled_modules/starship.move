module 0x7a42d0a5b97452f68014fc696be2693432d2c4e455568be2f97a8d1ca3abd2be::starship {
    struct STARSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARSHIP>(arg0, 6, b"Starship", b"Elonmusk Starship", b"Starship :https://x.com/elonmusk/photo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EL_On1_4174e4274f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARSHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARSHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

