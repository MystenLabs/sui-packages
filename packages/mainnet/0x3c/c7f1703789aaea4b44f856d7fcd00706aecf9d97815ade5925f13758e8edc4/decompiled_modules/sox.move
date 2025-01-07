module 0x3cc7f1703789aaea4b44f856d7fcd00706aecf9d97815ade5925f13758e8edc4::sox {
    struct SOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOX>(arg0, 6, b"SOX", b"Suiox", b"Ugh! First Sui Indian Chief on Suichain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/683_D0043_7511_459_D_93_B4_45_A70197_AC_7_E_5d70bdd30c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

