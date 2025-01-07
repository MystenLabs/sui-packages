module 0xda4806e13deb3e60cc4bcdad7bcb91d9b4081b99423bef8880a509f1553d8380::salmons {
    struct SALMONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMONS>(arg0, 6, b"SALMONS", b"Silly Salmon", b"The only splashiest meme token on the SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039147_efcf1571ac_1_954e857937.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALMONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

