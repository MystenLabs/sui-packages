module 0x80568f394eb39b689064aa3f278484a76277da954ca07c89ae73b5baaf3712e::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"Brett", b"Sui Brett", b"SUI BRETT The very first $Brett on Sui network Brett is the legendary character from Matt Furies Boys' club comic. He has become the blue mascot of the Sui chain. TG: https://t.me/SuiBrett_Sui X: https://x.com/Brett_SuiChain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000066517_e7cf77342b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

