module 0xbe1d6b555109b0fce12c3836d52d46de4d2462f5c6b0a5db0187db1c47b0660::spaamsui {
    struct SPAAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAAMSUI>(arg0, 6, b"SPAAMSUI", b"SPAMSUI", b"\"Spam to Earn\" a.k.a. \"Proof of Spam\" on Sui. Welcome to the community-owned page of $SPAM!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_211933546_1718977082.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAAMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

