module 0xdf41cd7cc82a964255d5994c576e250a788a01549b203ccfff6537d91d1c1f12::syn {
    struct SYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYN>(arg0, 6, b"SYN", b"SynapToken", x"53796e6170546f6b656e20282453594e29206973206120746f6b656e206f6e2074686520535549206e6574776f726b20666f72206120646563656e7472616c697a65642041492065636f73797374656d2e20497420737570706f727473207472616e73616374696f6e7320616e64206f6666657273206c6f7720636f7374732e204a6f696e2077697468202453594e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741946909433.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

