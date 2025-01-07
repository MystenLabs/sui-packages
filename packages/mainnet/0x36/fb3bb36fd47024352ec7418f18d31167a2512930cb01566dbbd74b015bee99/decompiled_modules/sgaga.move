module 0x36fb3bb36fd47024352ec7418f18d31167a2512930cb01566dbbd74b015bee99::sgaga {
    struct SGAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGAGA>(arg0, 6, b"SGAGA", b"GAGA SUI", b"NEXT MEME SGAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ru3d4j_WYAA_8p0_9e4baaca89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

