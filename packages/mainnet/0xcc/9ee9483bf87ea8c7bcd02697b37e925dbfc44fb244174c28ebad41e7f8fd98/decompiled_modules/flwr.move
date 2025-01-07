module 0xcc9ee9483bf87ea8c7bcd02697b37e925dbfc44fb244174c28ebad41e7f8fd98::flwr {
    struct FLWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLWR>(arg0, 9, b"FLWR", b"THE FLOWER", b"Develop FLOWER Memecoin, a fun and vibrant cryptocurrency inspired by the beauty and diversity of flowers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7738716-c862-4799-abad-648ad21d93fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

