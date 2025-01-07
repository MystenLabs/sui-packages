module 0xcf9a5b2ff973e0790f3eab934fb9dcd14eb165d7f198d4a238fc649579c903e5::bsudeng {
    struct BSUDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUDENG>(arg0, 6, b"BSUDENG", b"Baby Sudeng", b"Inspired by the meme sensation Moodeng, he embodies pure joy and curiosity. With his little horn and chubby body, Baby Sudeng navigates the world with endearing clumsiness and determination.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_23_09_57_c28a6601f1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

