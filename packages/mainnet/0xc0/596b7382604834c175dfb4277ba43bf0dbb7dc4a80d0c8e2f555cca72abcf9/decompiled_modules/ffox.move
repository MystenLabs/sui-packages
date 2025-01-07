module 0xc0596b7382604834c175dfb4277ba43bf0dbb7dc4a80d0c8e2f555cca72abcf9::ffox {
    struct FFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFOX>(arg0, 6, b"FFOX", b"FRISKY FOX", b"Playful, cunning, and ready to pounce. Frisky Fox is stealing hearts and gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_032255983_672407a735.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

