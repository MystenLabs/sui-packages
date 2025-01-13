module 0xb83c0b24a3bc82188d617a5729422530857d78117f47b17c752f1eff50529219::cheepo {
    struct CHEEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHEEPO>(arg0, 6, b"CHEEPO", b"GOAT OF SUI by SuiAI", b"In the crypto space, CHEEPO stands out. 'GOAT,' within the CHEEPO concept, isn't just an animal; it's an acronym for 'greatest of all time,' reflecting the community's aspiration. Like real goats that can scale the steepest slopes, CHEEPO's ethos is centered around surmounting the toughest challenges in the market, aiming for the highest heights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/e_Ys_MH_SJ_400x400_8c0b546a22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHEEPO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEPO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

