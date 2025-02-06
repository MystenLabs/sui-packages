module 0xc7a130b00c9b780d728dc1b0da11a126ce8a939fe26bda73db63aa7271f946d0::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 9, b"SUICAT", b"CatOnSui", b"Meow meow meow lets make meme om sui great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0747f58-0ec5-45e1-9688-3deb2ef6bf85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

