module 0xf6441560562405d9d46ca53f8ba0f5ec19aabe14cd697915053f6b2a2112a05d::wolfsui {
    struct WOLFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLFSUI>(arg0, 6, b"WOLFSUI", b"WOLFSUI MAXUI", b"WolfSUI MAXUI is all about the power and instincts of SUIstreets strongest wolves. Its not just a meme coin, But its for those who are smart, strong, and ready", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_a3ece60bc9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

