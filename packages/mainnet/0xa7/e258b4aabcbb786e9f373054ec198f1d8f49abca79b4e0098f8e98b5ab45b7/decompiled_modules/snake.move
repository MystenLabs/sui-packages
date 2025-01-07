module 0xa7e258b4aabcbb786e9f373054ec198f1d8f49abca79b4e0098f8e98b5ab45b7::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 6, b"SNAKE", b"Sui Snake", b"Introducing Sui Snake, Slithering through the Sui network, this snake strikes fast and leaves no room for the weak.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mgi_D_Hn_YV_Sh_SH_Pt946_Crtw_1_bf91c73c20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

