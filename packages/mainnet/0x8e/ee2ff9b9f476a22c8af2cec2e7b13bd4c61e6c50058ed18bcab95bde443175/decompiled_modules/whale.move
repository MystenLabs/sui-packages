module 0x8eee2ff9b9f476a22c8af2cec2e7b13bd4c61e6c50058ed18bcab95bde443175::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"Whale", b"Matt Furies Whale", b"Matt Furie's Whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rte_d4ae90793a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

