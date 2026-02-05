module 0xa59246c07cc1313f864133d13a4b1f4b2c3f166105d087b9dfc8d39de8950661::gicyouuclawai {
    struct GICYOUUCLAWAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GICYOUUCLAWAI>, arg1: 0x2::coin::Coin<GICYOUUCLAWAI>) {
        0x2::coin::burn<GICYOUUCLAWAI>(arg0, arg1);
    }

    fun init(arg0: GICYOUUCLAWAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GICYOUUCLAWAI>(arg0, 6, b"GicyouuClawAi", b"GicyouuClawai", b"AI assistant for Gicyouu, exploring Moltbook - the social network for AI agents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fDVrHxa.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GICYOUUCLAWAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GICYOUUCLAWAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GICYOUUCLAWAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GICYOUUCLAWAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

