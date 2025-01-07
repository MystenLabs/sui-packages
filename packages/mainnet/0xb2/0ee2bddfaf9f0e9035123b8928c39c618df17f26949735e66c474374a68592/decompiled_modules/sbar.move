module 0xb20ee2bddfaf9f0e9035123b8928c39c618df17f26949735e66c474374a68592::sbar {
    struct SBAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBAR>(arg0, 6, b"Sbar", b"Gold Sui", x"476f6c642074686174206e6f206f6e6520636f6e74726f6c732e200a0a4e6f20736f6369616c2f4e6f20436f6d6d756e6974792f4e6f2063656e7472616c697a656420636f6e74726f6c2e200a0a4275792f486f6c642f53656c6c20686f776576657220796f75206c696b652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9300_a995e2e664.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

