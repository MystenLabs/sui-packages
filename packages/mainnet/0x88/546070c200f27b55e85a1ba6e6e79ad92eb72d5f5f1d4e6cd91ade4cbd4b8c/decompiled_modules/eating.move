module 0x88546070c200f27b55e85a1ba6e6e79ad92eb72d5f5f1d4e6cd91ade4cbd4b8c::eating {
    struct EATING has drop {
        dummy_field: bool,
    }

    fun init(arg0: EATING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EATING>(arg0, 6, b"Eating", b"They're eating the Cats", b"\"They're eating the dogs/ they're eating the cats/ they're eating the pets of the people who live there.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0177_bde0f79f37.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EATING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EATING>>(v1);
    }

    // decompiled from Move bytecode v6
}

