module 0x6d526dfd616c964ea48f244a48dd979678543ac20e8c13379f0fbbb0cf8e97b1::pdeng {
    struct PDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDENG>(arg0, 6, b"PDENG", b"PumpkinMoodeng", b"PumpkinMoodeng is a nearly worthless FUN MEME token, featuring a cute Halloween-themed version of Moodeng from Thailands Zoo. In the crypto world, the word pump is lovedand with Halloween just around the corner, theres no better time! Lets spread the joy of PumpkinMoodengs cuteness and make the world a little happier, one meme at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pdeng_d3b15f0b2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

