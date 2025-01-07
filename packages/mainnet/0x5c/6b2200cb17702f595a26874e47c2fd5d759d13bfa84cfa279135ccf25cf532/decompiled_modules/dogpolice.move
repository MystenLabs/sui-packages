module 0x5c6b2200cb17702f595a26874e47c2fd5d759d13bfa84cfa279135ccf25cf532::dogpolice {
    struct DOGPOLICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGPOLICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGPOLICE>(arg0, 6, b"DOGPOLICE", b"SuiPolice Dog", b"$DOGPOLICE helps secure and guarantee security, comes with the power of intelligence and skills that can make it safe and secure on sui networks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001503_468dc4e094.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGPOLICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGPOLICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

