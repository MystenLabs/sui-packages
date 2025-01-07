module 0x35257fbdd1330184753624ec47c1549c413987a8a1d74e4acc3d6aca5c8555f0::pkmeme {
    struct PKMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKMEME>(arg0, 6, b"PKMEME", b"Pokememe On Sui", x"412070617373696f6e2070726f6a65637420626f726e2066726f6d206f7572206c6f7665206f6620506f6b6d6f6e20616e6420696e7465726e6574206d656d652063756c7475726520706f6b656d656d65746f6b656e2e66756e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/673c5eb1bc2c2011db3a6c5e_Your_paragraph_text_66_a3bfdb1dbb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

