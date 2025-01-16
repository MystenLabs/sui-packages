module 0x7d627f6263e7eed6215ffa4db48d711cd86cb8d913da9fa42f549c525d05000c::barkley {
    struct BARKLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARKLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARKLEY>(arg0, 6, b"Barkley", b"Barkley Dog", b"ONCE UPON A TIME, IN THE MYSTICAL REALM OF \"DOGE ISLAND,\" LIVED A VARIETY OF ADORABLE DOGS THAT WERE KNOWN FOR THEIR SPIRITED PERSONALITIES AND LOVE FOR ADVENTURE. AMONG THEM WAS A PARTICULARLY ADVENTUROUS DOG NAMED \"BARKLEY,\" WHO DREAMED OF BRINGING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737056030326.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARKLEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARKLEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

