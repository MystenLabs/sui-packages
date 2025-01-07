module 0xad2762340b3b8d2d35bd319086e3c6cc19e172c7d0652f9356fbe13d6dccc044::usug {
    struct USUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUG>(arg0, 6, b"USUG", b"U SELL U GAY", b"Welcome to U SELL U GAY ($USUG), a groundbreaking project on the Sui blockchain that is more than just a tokenit's a movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_35_33_c101dc73aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

