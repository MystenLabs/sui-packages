module 0x6e37bfde0e0b775f150c87920b93f8e110f75e5fdf846762596f48b02b1a76e5::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 6, b"SPEPE", b"Sui Pepe", b"SuiPepe ($SPEPE) is a meme coin built on the Sui Network, combining the power of fast transactions with the culture of internet memes. Designed for the community, powered by humor!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741463499494.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

