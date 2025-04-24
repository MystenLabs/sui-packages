module 0xedbd60b76921b5e6e8cb0ed9875f3d9a8ba9f3655aad614b4517a3bab274d8c5::spikashi {
    struct SPIKASHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIKASHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIKASHI>(arg0, 6, b"SPIKASHI", b"Sui Spikashi", b"Spikashi is a movement. Inspired by the Down syndrome fitness legend who's lifting hearts and heavy weights, Leii Coin spreads awareness, joy, and positivity through unstoppable energy. This token celebrates strength in all forms: physical, emotional, communal, and turns every buy into a statement: we support inclusion, determination, and real-life heroes. Whether you're here for the gains or the good vibes, $SPIKASHI is your chance to back a coin with real meaning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061867_e899d38378.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIKASHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIKASHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

