module 0x493236f30609830c5c5d7c58b3659423ef2b2d34d0406c68c60f17a05d0e79ac::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONKEY", b"Monkey on SUI", b"Join me, and lets throw it all on the line! Gamble your life savings against some shiny golden bananas! Who knows, maybe you'll swing out richer...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GAA_Qrk2_U_400x400_119df55797.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

