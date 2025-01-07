module 0x72675629146d03252ac7103e4309b5106d278605552a7d44c5995a3a73bfe6e4::vinland {
    struct VINLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINLAND>(arg0, 6, b"Vinland", b"Sojourner", b"Far west, across the sea, there is a land called Vinland. It's warm. And fertile. A faraway land where neither slave traders nor the flames of war reach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731641306357.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINLAND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINLAND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

