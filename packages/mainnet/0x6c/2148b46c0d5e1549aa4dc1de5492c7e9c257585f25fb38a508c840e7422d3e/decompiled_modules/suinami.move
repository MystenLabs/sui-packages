module 0x6c2148b46c0d5e1549aa4dc1de5492c7e9c257585f25fb38a508c840e7422d3e::suinami {
    struct SUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMI>(arg0, 6, b"SUINAMI", b"SuiNami", b"Diving deep into the trenches of the ocean of sui coins ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suinami_64c6bb717d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

