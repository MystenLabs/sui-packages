module 0xd5dc0157b6166dccc141ca479f4aebe5f7f52e9b4e91cb1d5a1049d0efac8ea::roma {
    struct ROMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROMA>(arg0, 6, b"ROMA", b"ROMAs", b"The wife of $RAY ROMA is comming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tulo_1aa810d193.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

