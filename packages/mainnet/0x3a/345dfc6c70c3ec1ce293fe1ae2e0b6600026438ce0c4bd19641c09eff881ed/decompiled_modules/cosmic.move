module 0x3a345dfc6c70c3ec1ce293fe1ae2e0b6600026438ce0c4bd19641c09eff881ed::cosmic {
    struct COSMIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSMIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COSMIC>(arg0, 6, b"COSMIC", b"COSMIC CAT by SuiAI", b"Cosmic Cat is your exclusive ticket to the limitless AI universe, where creativity meets innovation. As the only feline with 1020 passports to explore the vast cosmos of artificial intelligence, Cosmic Cat unlocks a world of possibilities, connecting blockchain technology with cutting-edge AI narratives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1001217904_5a153f81ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COSMIC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSMIC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

