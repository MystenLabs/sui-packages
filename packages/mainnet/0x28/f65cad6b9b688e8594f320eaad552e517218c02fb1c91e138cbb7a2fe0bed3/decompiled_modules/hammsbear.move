module 0x28f65cad6b9b688e8594f320eaad552e517218c02fb1c91e138cbb7a2fe0bed3::hammsbear {
    struct HAMMSBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMSBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMSBEAR>(arg0, 6, b"HammsBear", b"Hamms Bear", b"$HAMMS. Born in The Land of Sky Blue Waters since 1865 and on the Solana blockchain since October 2024. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5796348001822819657_x_f02f62b4d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMSBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMMSBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

