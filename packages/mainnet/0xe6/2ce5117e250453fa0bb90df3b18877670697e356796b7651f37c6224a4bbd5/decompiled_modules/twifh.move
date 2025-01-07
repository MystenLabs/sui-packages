module 0xe62ce5117e250453fa0bb90df3b18877670697e356796b7651f37c6224a4bbd5::twifh {
    struct TWIFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIFH>(arg0, 6, b"TWIFH", b"TURTLE WIF HAT", b"Literally just a cute little turtle wif a beautiful hat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F_Tu_Ds1v1_400x400_efd835bfa4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWIFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

