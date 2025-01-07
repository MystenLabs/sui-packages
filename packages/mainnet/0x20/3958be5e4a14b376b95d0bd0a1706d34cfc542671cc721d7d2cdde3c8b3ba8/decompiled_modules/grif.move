module 0x203958be5e4a14b376b95d0bd0a1706d34cfc542671cc721d7d2cdde3c8b3ba8::grif {
    struct GRIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIF>(arg0, 6, b"GRIF", b"Griffon Gold", b"Rainbow Griffons is a rare collection of vibrant, mythical guardians uniquely crafted with dazzling feathers and a dash of pure magic. These Griffons aren't just avatars; they're guardians of the blockchain, hodling diamonds, and flaunting mythic mints. Each Griffon holds a unique power, embodying the spirit of luck, adventure, and prosperity. Owners of Rainbow Griffons gain access to an exclusive world of treasure hunts, rare drops, and community perks that only the worthy can unlock. GRIF is the token the powers the immersive world of the Griffon multiverse. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/grif_086e943477.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

