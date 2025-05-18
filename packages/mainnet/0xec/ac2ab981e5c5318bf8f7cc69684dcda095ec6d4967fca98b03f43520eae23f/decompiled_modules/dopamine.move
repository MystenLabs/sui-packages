module 0xecac2ab981e5c5318bf8f7cc69684dcda095ec6d4967fca98b03f43520eae23f::dopamine {
    struct DOPAMINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPAMINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPAMINE>(arg0, 6, b"DOPAMINE", b"GEN-Z Currency", b"Gen Z's constant exposure to digital devices and social media, which trigger dopamine release with each notification, interaction, and achievement, may contribute to a form of dopamine addiction. This addiction can manifest as decreased attention span, increased mental health issues, and difficulty finding pleasure in activities outside of the digital realm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigcqmg3asdm76rewzwt62dymz6sjvm5zsuexnpqy7ysnrcaa4tcim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPAMINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOPAMINE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

