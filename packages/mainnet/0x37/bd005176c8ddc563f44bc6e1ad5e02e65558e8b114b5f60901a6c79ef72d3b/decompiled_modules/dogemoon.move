module 0x37bd005176c8ddc563f44bc6e1ad5e02e65558e8b114b5f60901a6c79ef72d3b::dogemoon {
    struct DOGEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEMOON>(arg0, 6, b"DogeMoon", b"MoonDoge", b"Doge go to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_Sd_H3_Vc_H_400x400_fotor_bg_remover_20240912124626_0b2b8d626c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

