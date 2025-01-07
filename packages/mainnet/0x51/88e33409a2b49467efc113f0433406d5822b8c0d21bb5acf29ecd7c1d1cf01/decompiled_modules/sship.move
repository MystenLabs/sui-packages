module 0x5188e33409a2b49467efc113f0433406d5822b8c0d21bb5acf29ecd7c1d1cf01::sship {
    struct SSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIP>(arg0, 6, b"SSHIP", b"SHIP of SUI", b"SHIP Ahoy, mateys! Set sail on the Sui waters with SHIP and get ready to plunder the Sui seas! SHIP is here to navigate the waves of the Sui network and lead its crew to untold treasures. Get on board, hoist the sails, and lets chart a course to the moon, one adventure at a time!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHIP_d2941bdc64.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

