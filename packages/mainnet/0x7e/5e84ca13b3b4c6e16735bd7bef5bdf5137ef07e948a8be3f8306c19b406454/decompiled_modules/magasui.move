module 0x7e5e84ca13b3b4c6e16735bd7bef5bdf5137ef07e948a8be3f8306c19b406454::magasui {
    struct MAGASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGASUI>(arg0, 6, b"MAGASUI", b"Maga Sui", b"MAGA Token on SUI: The Patriot-Powered Crypto Revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MAGASUI_f36ead9b72.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

