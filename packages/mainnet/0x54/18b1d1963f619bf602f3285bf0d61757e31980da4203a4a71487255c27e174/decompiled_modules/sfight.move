module 0x5418b1d1963f619bf602f3285bf0d61757e31980da4203a4a71487255c27e174::sfight {
    struct SFIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFIGHT>(arg0, 6, b"Sfight", b"Sui Fight", b"Sui fights and defeats Sol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_5a2f652681.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

