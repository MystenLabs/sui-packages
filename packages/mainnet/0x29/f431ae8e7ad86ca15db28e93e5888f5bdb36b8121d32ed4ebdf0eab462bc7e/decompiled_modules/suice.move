module 0x29f431ae8e7ad86ca15db28e93e5888f5bdb36b8121d32ed4ebdf0eab462bc7e::suice {
    struct SUICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICE>(arg0, 6, b"Suice", b"Sui Ice", b"Chill out with $SUICE, the coolest coin on the Sui blockchain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suice_656c2e2bed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

