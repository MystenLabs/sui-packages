module 0xe8cb02e2533e0d5d3890910519d42b40dbba7f7dcdd8331bf180fa365211e02b::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 9, b"WOOF", b"Woof Bucks", b"Woof Bucks is a dog-inspired meme coin focused on community and fun. Each transaction supports dog-themed giveaways, animal shelter donations, and rewards for members. Trade, hold, and enjoy with WOOF!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7affddab-820a-457b-9f42-6e755f1e3767.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

