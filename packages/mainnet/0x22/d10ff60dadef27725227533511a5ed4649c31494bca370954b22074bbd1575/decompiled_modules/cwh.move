module 0x22d10ff60dadef27725227533511a5ed4649c31494bca370954b22074bbd1575::cwh {
    struct CWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWH>(arg0, 6, b"CWH", b"CAPY WIF HAT", b"The capybara in the logo has a friendly and approachable appearance, designed with simple and modern lines. It wears a stylish hat, adding a playful and unique touch. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0d10d0101_857fefc654.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

