module 0x35e213a48432aa460bdf64fa612889ff8c409fa38ac4b16efab00dbaf3ff74a4::flxcat {
    struct FLXCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLXCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLXCAT>(arg0, 6, b"FLXCAT", b"FelixTheCat On Sui", b"The Legendary Celebrity Cat, Returns on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002237_d9ab74153c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLXCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLXCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

