module 0x70b99c940cf35d54727bd793b28a26103ddbe73ce5a2ef1bb9e973a6877e8e8a::lyal {
    struct LYAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LYAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYAL>(arg0, 6, b"LYAL", b"LOVE YOU ALL", b"Love You All isn't just another dog coin.Its a celebration of community.Its a symbol of unity,loyalty,possitivity and utility.LYAL now has physical business in EU, and the community will benefit from its revenue.''stay tuned, more is coming soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730981898793.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LYAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LYAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

