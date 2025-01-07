module 0xec8aa23b14ff506c6db28e65562aa59f26a5904b5e3c9a727eadcbae1daf2446::mort {
    struct MORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORT>(arg0, 6, b"MORT", b"MORTA", b"Morta the Cat is a playful and community-centric SUI token inspired by the cunning and adventurous spirit of a cat. Morta embodies agility, curiosity, and the ability to navigate challenges with ease, making it a symbol of resilience and growth within the SUI ecosystem. Join Mortas journey to explore new horizons and unlock rewards, as this token captures the essence of fun and innovation on the blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/32f98850_270e_4ff3_845e_e7a044212700_2df68f5269.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORT>>(v1);
    }

    // decompiled from Move bytecode v6
}

