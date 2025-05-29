module 0x907f6680b1690491b4dec8b9a188c82b8ec0ef6ab96d8604cdc8923b003daa33::shth {
    struct SHTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHTH>(arg0, 6, b"SHTH", b"Shortist", b"The Shortist project token, the idea of the project is for each token holder to profit from the income of a team of traders. After the listing, the coin staking mechanism will be implemented. And each holder was able to earn money by holding.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748455766059.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

