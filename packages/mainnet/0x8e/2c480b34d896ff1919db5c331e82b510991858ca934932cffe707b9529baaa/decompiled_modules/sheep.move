module 0x8e2c480b34d896ff1919db5c331e82b510991858ca934932cffe707b9529baaa::sheep {
    struct SHEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEP>(arg0, 6, b"SHEEP", b"SHEEP ON SUI", b"My 11 year old son's teacher and teacher don't believe you can earn money with a memecoin. So my son and i created SHEEP because we are from the Netherlands. Who wants to join this challenge? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cj11_G_Db_M_Sl_GBRAB_Wa_Q_Xyhw_960a994035.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

