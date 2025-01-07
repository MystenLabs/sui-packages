module 0x578e506ec423b7a090561d12bc6432410b77f26934e19c70ec68b21547084176::earth {
    struct EARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARTH>(arg0, 6, b"EARTH", b"Sui Earth", b"EARTH (Sui Earth) is the solid ground of the Sui Network. Rooted in the deep waters of Sui, this token is here to bring balance and growth to the ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_53_e86498251c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EARTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

