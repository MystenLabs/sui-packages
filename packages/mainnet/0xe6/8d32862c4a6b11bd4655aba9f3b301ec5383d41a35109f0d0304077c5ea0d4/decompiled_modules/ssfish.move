module 0xe68d32862c4a6b11bd4655aba9f3b301ec5383d41a35109f0d0304077c5ea0d4::ssfish {
    struct SSFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSFISH>(arg0, 6, b"SSFISH", b"SUI STARFISH", b"SuiStarFish is a meme coin that aims to bring fun and community spirit to the crypto world. Join us as we navigate the seven oceans of the blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OW_8_MX_Ciy_400x400_6236b233ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

