module 0xdee61b183035f4fa2ad80ff2350251b2218ef7b50622c73ea98830db4d05aa5c::yoot {
    struct YOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOOT>(arg0, 6, b"YOOT", b"YOOTEENJANUS", x"466c617669757320506574727573205361626261746975732049757374696e69616e75730a50657220696e6665726f732c207370656d206d65616d207365717561720a4c6f76652077696e7320616c6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdf_4b380107e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

