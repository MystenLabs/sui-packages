module 0xeb7bfad5b75ce0800f5acc8f04b40b87e326017815aebfafd39b7badc4f0adb8::dopamine {
    struct DOPAMINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPAMINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPAMINE>(arg0, 6, b"DOPAMINE", b"GEN-Z Currency", b"Gen Z's heavy reliance on digital media and instant gratification can lead to a state of \"dopamine addiction,\" where the brain becomes overly reliant on the pleasure-seeking neurotransmitter, dopamine, for stimulation. This can result in shorter attention spans, increased anxiety, and difficulty enjoying slower, more mindful activities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigcqmg3asdm76rewzwt62dymz6sjvm5zsuexnpqy7ysnrcaa4tcim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPAMINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOPAMINE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

