module 0xa100c436d1e65f72d582146746da172549bdbe5e23d7ba94b7ca1eee411c3416::pochi {
    struct POCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHI>(arg0, 6, b"POCHI", b"Pochi on Sui", b"POCHI embodies the essence of Japanese mochi  soft, delightful, and irresistibly enjoyable. Just as mochi has delighted taste buds for centuries, POCHI aims to capture hearts and minds in the crypto world with its playful and engaging spirit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_11_15_45_26_e1cfc4269d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

