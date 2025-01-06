module 0xd55d8838f4845f71e3bcd2e7ce7d333d28a962a88a52045d86bf4de6966eced7::bbsnek {
    struct BBSNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBSNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBSNEK>(arg0, 6, b"BBSNEK", b"Baby Snek", b"Little SNEK brothers who lived and grew up in the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021614_f52e184951.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBSNEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBSNEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

