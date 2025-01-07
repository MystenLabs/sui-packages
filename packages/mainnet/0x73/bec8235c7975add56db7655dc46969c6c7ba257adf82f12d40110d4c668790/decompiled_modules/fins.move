module 0x73bec8235c7975add56db7655dc46969c6c7ba257adf82f12d40110d4c668790::fins {
    struct FINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINS>(arg0, 6, b"FINS", b"SUIFINS", b"At Suifins, we believe that the community is at the heart of every successful project. We are committed to creating an environment that supports growth, innovation, and engagement. Through creative and unique initiatives, we strive to build loyalty and interest among our users. We aim to explore growth potential in a dynamic market and create long-term value for all Suifins holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241103_021440_978575c03a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

