module 0x32a9d2a70ae4e478ac4e724f77105a4a4e9908d5896e097f2db0b45915ccc291::olps {
    struct OLPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLPS>(arg0, 6, b"Olps", b"OLPS", b"Inverted Splo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/splo_38fe5104e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

