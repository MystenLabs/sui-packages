module 0x44650bd8a400579e84a556fd59f680dc9abded0115f010145f3dba7c2d45bed2::moondog {
    struct MOONDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDOG>(arg0, 6, b"MOONDOG", b"MoonDog Sui", b"Moondog spent many sleepless nights staring up at the sky...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_b53940b3ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

