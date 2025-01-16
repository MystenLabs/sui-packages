module 0xa79be2ba5ab2146544b6061f7a87636a461faf11c807760a678e24a8acd3cb48::barkley {
    struct BARKLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARKLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARKLEY>(arg0, 6, b"Barkley", b"Barkley Dog", b"ONCE UPON A TIME, IN THE MYSTICAL REALM OF \"DOGE ISLAND,\" LIVED A VARIETY OF ADORABLE DOGS THAT WERE KNOWN FOR THEIR SPIRITED PERSONALITIES AND LOVE FOR ADVENTURE. AMONG THEM WAS A PARTICULARLY ADVENTUROUS DOG NAMED \"BARKLEY,\" WHO DREAMED OF BRINGING JOY AND LAUGHTER TO EVERYONE IN THE HUMAN WORLD. BARKLEY BELIEVED THAT EVERY BARK CARRIED A MESSAGE, AND HE SET OUT ON A QUEST TO SPREAD POSITIVITY, KINDNESS, AND A SENSE OF COMMUNITY. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wfc_logo_1_a22468f517.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARKLEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARKLEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

