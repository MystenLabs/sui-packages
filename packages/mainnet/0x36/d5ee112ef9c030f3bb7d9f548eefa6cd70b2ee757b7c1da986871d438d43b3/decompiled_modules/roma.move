module 0x36d5ee112ef9c030f3bb7d9f548eefa6cd70b2ee757b7c1da986871d438d43b3::roma {
    struct ROMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROMA>(arg0, 6, b"ROMA", b"ROMA girlfriend of ray", b"The wife of $RAY ROMA is comming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tulo_1aa810d193.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

