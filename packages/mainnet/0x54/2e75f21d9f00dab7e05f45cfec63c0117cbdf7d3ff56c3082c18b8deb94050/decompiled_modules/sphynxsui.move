module 0x542e75f21d9f00dab7e05f45cfec63c0117cbdf7d3ff56c3082c18b8deb94050::sphynxsui {
    struct SPHYNXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPHYNXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPHYNXSUI>(arg0, 6, b"SphynxSui", b"Sphynxsuicoin", b"Sphynx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_02_23_51_53_584ee42502.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPHYNXSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPHYNXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

