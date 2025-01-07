module 0x26153158d144f1eba231a95e5b351c82a504a8caef682d68d3ea9cc29f3b9394::kagasou {
    struct KAGASOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAGASOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAGASOU>(arg0, 6, b"Kagasou", b"Son of Kagasou", b"Daughter of Kagasou - in real life dog that was inspiration for SHIBA INU cryptocurency. Kagasou is already on full send mode. Let's follow the family path. It's time for his daughter to catch up .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_11_40_29_00145ed9ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAGASOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAGASOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

