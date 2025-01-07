module 0x170def4416cc69a4eee8409a74a1fbdfbd8a0bcb1fc7bc34ef1ef0b1d4f782c3::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"The Puffer Fish", b"$PUFF  a clueless yellow puffer fish who's always swimming headfirst into chaos. Whether he's inflating at the wrong time, getting caught in a fishing net, or mistaking a sea anemone for a friend, $PUFF's adventures are as unpredictable as the market itself! $PUFF is the community meme coin that knows how to make waves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Puff_Thumbnail_Circled_ca82d05c9c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

