module 0x39dc7abadc5708344ef7c1184444ec6d393bc62d6301a6ab8e2869cd8d59fac4::mumu {
    struct MUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMU>(arg0, 6, b"MUMU", b"Sui Bull Amumu", b"Who likes not his business, his business likes not him", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mumu_60ef5feda5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

