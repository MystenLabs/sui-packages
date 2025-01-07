module 0x912ae9f00166f09228347b4f9bc8d723bd7a7e25332a3241c5a083cf9e8e00e3::oggycat {
    struct OGGYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGYCAT>(arg0, 9, b"OGGYCAT", b"Oggy", b"This is a reliable meme coin with a strong community, which is derived from the Ogi animation, and it is possible that its price will increase several times in a few weeks, and you can buy it at a low price.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/862062f4-7b48-4dc5-9f75-98a38d1debf7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGGYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

