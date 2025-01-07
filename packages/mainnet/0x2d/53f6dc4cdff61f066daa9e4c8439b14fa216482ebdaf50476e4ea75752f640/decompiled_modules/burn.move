module 0x2d53f6dc4cdff61f066daa9e4c8439b14fa216482ebdaf50476e4ea75752f640::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURN>(arg0, 6, b"BURN", b"Sui Fireboy", b"Dive into a dynamic meme universe where Burnie and friends embark on epic quests, and you influence their story.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FIRE_ee08bdb5f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURN>>(v1);
    }

    // decompiled from Move bytecode v6
}

