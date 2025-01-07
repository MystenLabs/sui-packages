module 0xb608001c3c2ade0b58438ca2836a61bdd23c7f1d15a6dfefacb231bf8ae3377d::sgt {
    struct SGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGT>(arg0, 6, b"SGT", b"Squid Game Token", b"Play with us, Change ur destiny!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6243562456_666af0c4be.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

