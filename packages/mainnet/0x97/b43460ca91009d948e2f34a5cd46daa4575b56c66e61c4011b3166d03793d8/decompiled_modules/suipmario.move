module 0x97b43460ca91009d948e2f34a5cd46daa4575b56c66e61c4011b3166d03793d8::suipmario {
    struct SUIPMARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPMARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPMARIO>(arg0, 6, b"SUIPMARIO", b"Suiper Mario fun", b"SUIPER MARIO on SUI is a meme inspired by the SUPER MARIO BROSS game, it reflects optimism, strength and charisma, everything a good Con meme needs...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1734392301824_8c9a6fa4e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPMARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPMARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

