module 0x343a76e0282485277eae04acb2c232fec37d9378ef85d6ca52ce61b21d8adf39::iceland {
    struct ICELAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICELAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICELAND>(arg0, 6, b"ICELAND", b"ICELAND on SUI", b"Ice Land is the OG character alter-ego of Landwolf in the \"Boys Club\" comic series by Matt Furie. $ICE on SUI Loves drinking, stinking, and never thinking.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_E_Bas_QGX_400x400_a19c9dc411.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICELAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICELAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

