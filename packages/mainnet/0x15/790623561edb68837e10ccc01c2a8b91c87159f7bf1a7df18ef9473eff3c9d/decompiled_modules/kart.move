module 0x15790623561edb68837e10ccc01c2a8b91c87159f7bf1a7df18ef9473eff3c9d::kart {
    struct KART has drop {
        dummy_field: bool,
    }

    fun init(arg0: KART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KART>(arg0, 6, b"KART", b"Retardio Kart", x"526574617264696f206f6e20776865656c732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kn_Cj_Bkk_R_400x400_0440f52642.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KART>>(v1);
    }

    // decompiled from Move bytecode v6
}

