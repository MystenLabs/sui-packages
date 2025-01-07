module 0x484423d188611b3efd41d1800e9ac8fb8e0559efe7bc5d7fbde0af29b90e6308::jims {
    struct JIMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIMS>(arg0, 6, b"Jims", b"Jims The Plankton", b"JIMS is the forgotten King of the plankton nation, for years enjoying life as an ordinary plankton, now a box is opened to the fact that he is the real king, let's help JIMS fulfill his destiny, and Atlantis is a gift for us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOJO_AI_a_cartoon_pickle_with_a_blue_hat_and_a_shocked_loo_ab8543174d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

