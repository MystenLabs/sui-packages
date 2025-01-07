module 0xf0568f78512b1edee34e66c1063126b23fc73e97f1dd8df8986173423a575a69::suina {
    struct SUINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINA>(arg0, 6, b"SUINA", b"SUINA QUEEN", b"Suina is the queen of the vast, mysterious underwater kingdom of Sui. She has superpowers that brought her to ascendancy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suina_a56ea0e6b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

