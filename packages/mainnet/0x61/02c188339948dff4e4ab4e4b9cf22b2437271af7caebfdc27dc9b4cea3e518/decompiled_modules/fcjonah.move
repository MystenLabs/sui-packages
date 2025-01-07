module 0x6102c188339948dff4e4ab4e4b9cf22b2437271af7caebfdc27dc9b4cea3e518::fcjonah {
    struct FCJONAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCJONAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCJONAH>(arg0, 6, b"fcJonah", b"Jonah is Moo Deng's mom.", b"Jonah , Mother of Moodeng ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g056_J4a_K_400x400_307c18e820.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCJONAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCJONAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

