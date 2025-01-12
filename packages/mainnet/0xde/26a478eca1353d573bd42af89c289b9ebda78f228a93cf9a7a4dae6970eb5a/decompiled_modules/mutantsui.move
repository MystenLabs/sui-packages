module 0xde26a478eca1353d573bd42af89c289b9ebda78f228a93cf9a7a4dae6970eb5a::mutantsui {
    struct MUTANTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTANTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTANTSUI>(arg0, 6, b"MUTANTSUI", b"MUTANT ON SUI", b"$MUTANT SUI is a unique and grotesquely vibrant collection of digital art that combines the surreal and psychedelic with extreme mutant style. Each piece is filled with intense colors, melting textures and electrifying details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736680317100.35")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUTANTSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTANTSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

