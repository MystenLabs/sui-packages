module 0xebf96e8116893559af9fb204f0146ab858282c16f4d545be5f3b7aeb320e605f::pengsnake {
    struct PENGSNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGSNAKE>(arg0, 6, b"PENGSNAKE", b"Pengsui Snake", b"Unleash the Serpent! Pudgypengu is slithering into 2025.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_28_at_6_15_25a_AM_ddd255592c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGSNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGSNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

