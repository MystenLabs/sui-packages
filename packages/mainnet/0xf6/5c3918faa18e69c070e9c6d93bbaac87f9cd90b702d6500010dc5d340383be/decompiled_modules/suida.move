module 0xf65c3918faa18e69c070e9c6d93bbaac87f9cd90b702d6500010dc5d340383be::suida {
    struct SUIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDA>(arg0, 6, b"SUIDA", b"Sui Ishida", b"Sui Ishida is a Japanese manga artist. He is popularly known for his dark fantasy manga series Tokyo Ghoul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_08_38_182e9af81d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

