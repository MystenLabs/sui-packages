module 0x5e073ca2ce1bf4f0807b74eb83b314845d3ab0559fffe7a18010ca37978a67de::winfo {
    struct WINFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINFO>(arg0, 6, b"Winfo", b"Winfo on sui", b"we  will be the top  memecoin on sui net work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vch4a_O_Gp_400x400_61db68d4f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

