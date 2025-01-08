module 0x278a344e1a723e5c087fbaf374c5bf5aadcc7155f20c36c73cd09f2ebaf0bbfd::daos {
    struct DAOS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DAOS>, arg1: 0x2::coin::Coin<DAOS>) {
        0x2::coin::burn<DAOS>(arg0, arg1);
    }

    fun init(arg0: DAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAOS>(arg0, 6, b"Hi fuckin there", b"Hi", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DAOS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<DAOS>(arg0) == 0, 0);
        0x2::coin::mint_and_transfer<DAOS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

