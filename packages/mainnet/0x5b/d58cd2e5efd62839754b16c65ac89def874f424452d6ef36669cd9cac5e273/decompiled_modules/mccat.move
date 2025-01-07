module 0x5bd58cd2e5efd62839754b16c65ac89def874f424452d6ef36669cd9cac5e273::mccat {
    struct MCCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCCAT>(arg0, 6, b"McCat", b"Mc CAT Sui", b"There is no meme, $MCCAT just trying to get work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_23_43_04_ba389b2f25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

