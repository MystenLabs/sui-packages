module 0x1d7f9fb3550449ed6c289198f0e80549e3c439d33cabbec2c1be84b7892eebf9::aaaswift {
    struct AAASWIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASWIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASWIFT>(arg0, 6, b"AAASWIFT", b"aaa Swifties", b"Taylor swift on SUI aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Rocking to #1 on the charts!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/swiftie_ea315a22bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASWIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASWIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

