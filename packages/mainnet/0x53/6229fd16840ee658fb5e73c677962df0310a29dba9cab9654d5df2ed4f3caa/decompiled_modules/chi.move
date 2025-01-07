module 0x536229fd16840ee658fb5e73c677962df0310a29dba9cab9654d5df2ed4f3caa::chi {
    struct CHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHI>(arg0, 6, b"CHI", b"CHICHI", b"Chi's Sweet Home  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/El_Dulce_Hogar_De_Chi_65abbf7c13.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

