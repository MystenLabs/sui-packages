module 0x7dabd537d7e11156687df5d6ddc8a0b20cb1c41766acf7aaf2a42de052126f56::wolly {
    struct WOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLLY>(arg0, 6, b"WOLLY", b"Woolly Mannoth", b"Woolly Mannoth, came from the ancient Woolly Mammoth creatures of the pre-historic ages. An another NFT character made by Matt Furie. Featured in his renowned Hedz collection and various other works. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241217_200610_060_01b5290b23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

