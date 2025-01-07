module 0x51865fcdc39fcdf13fb4a7685d41ce050ef56543e3f187b34ca1edafe9ed48b3::suica {
    struct SUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICA>(arg0, 6, b"SUICA", b"Suica", b"Suica (Japanese pronunciation: , Suika) is a prepaid rechargeable contactless smart card and electronic money system used as a fare card on train lines and other public transport systems in Japan, launched on November 18, 2001, by JR East. The card can be used across the nation as part of Japan's Nationwide Mutual Usage Service. The card is also widely used as electronic money for purchases at stores and kiosks, especially at convenience stores and within train stations. In 2018, JR East reported that Suica was used for 6.6 million daily transactions.As of October 2023, 95.64 million Suica (including Mobile Suica) have been issued, and 1.63 million stores accept payment via Suica's digital currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_10333a1898.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

