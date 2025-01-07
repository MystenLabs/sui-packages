module 0x6b44efa861fdefcaee2881e590878b64390a38f65cff1fdf80e1914c4b9a467d::suica {
    struct SUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICA>(arg0, 6, b"SUICA", b"Suica", b"SUICA SUICA SUICA SUICA SUICA SUICA SUICA SUICA SUICA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f5beb07fe200747d7be222f8fb7b9d1d_a1982ab286.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

