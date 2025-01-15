module 0xb3219004000a5c66505ff2ff7c565fac1dcf3aee7b137ad7694e17e3fbafe16a::bs {
    struct BS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BS>(arg0, 6, b"BS", b"Baby Shark", x"4920676f74207468697320736f6e6720696e206d792068656164206e6f7720736f20646f20796f750a4261627920536861726b20646f6f20646f6f20646f6f20646f6f20646f6f20646f6f200a0a742e6d652f6261627979736861726b6b7375690a782e636f6d2f6261627979736861726b6b7375690a796f75747562652e636f6d2f4042616279536861726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baby_shark_birthday_greeting_card_600nw_2332962073_35d9610287.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BS>>(v1);
    }

    // decompiled from Move bytecode v6
}

