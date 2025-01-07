module 0xfdad819b69fe3ce40a97ffc7930224115d281f83f9f404be562ff007b1655b73::kbs {
    struct KBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBS>(arg0, 6, b"KBS", b"Kabosu", x"546865206e616d65206f662074686520446f6765436f696e20646f672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/67013c81aeea15a9f6e77a52_welcome_922075af5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

