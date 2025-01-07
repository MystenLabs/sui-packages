module 0xef9fd6a0c68f6b6986d0bca1bf9686948c28709905f97083fd7b6bcd8784ae62::cmc {
    struct CMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMC>(arg0, 6, b"CMC", b"ChinMaoCat", b" With a mysterious gaze and a soft, fluffy coat, ChinMao cat has arrived to take over the crypto world! ChinMaoCat Coin represents cuteness with strength, a symbol of stability in a volatile market. Behind that adorable look lies an unexpected potential, and you wont want to miss the chance to invest in ChinMaoCat coin. Join us and become part of the royal cat community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_20_23_31_07_487cf12c90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

