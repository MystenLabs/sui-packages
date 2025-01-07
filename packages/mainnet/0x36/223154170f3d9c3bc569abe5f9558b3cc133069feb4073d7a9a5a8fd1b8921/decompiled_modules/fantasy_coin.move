module 0x36223154170f3d9c3bc569abe5f9558b3cc133069feb4073d7a9a5a8fd1b8921::fantasy_coin {
    struct FANTASY_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FANTASY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FANTASY_COIN>(arg0, 9, b"FANTASY_COIN", b"FANTASY", b"fantasy coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/177515664")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FANTASY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FANTASY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FANTASY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FANTASY_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

