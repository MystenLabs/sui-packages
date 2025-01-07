module 0x30dd32f6b1c0c9fdb6b448dbcba77990c2a1edb77347708975e736299cc2f141::bow {
    struct BOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOW>(arg0, 6, b"BOW", b"Bo'ohw'o'wo'er", b"Bo'ohw'o'wo'er is a meme project on the Sui Network inspired by the worldwide humor of saying \"bottle of water\" in a British accent. This playful twist on language has become a global inside joke, with endless memes about the British \"bo'ohw'o'wo'er.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731125871354.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

