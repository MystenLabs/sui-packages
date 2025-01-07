module 0x277ede1144d1213138f4cc1612c197a7c6c27a765200d772b602f99098fbdbe5::suijak {
    struct SUIJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJAK>(arg0, 6, b"SUIJAK", b"suijak", b"The legendary Wojak, now on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zkw_J4wa_AAA_Tzwm_fcb6639cd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

