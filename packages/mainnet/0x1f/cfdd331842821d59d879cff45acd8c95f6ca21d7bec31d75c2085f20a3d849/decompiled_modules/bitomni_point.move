module 0x1fcfdd331842821d59d879cff45acd8c95f6ca21d7bec31d75c2085f20a3d849::bitomni_point {
    struct BITOMNI_POINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOMNI_POINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOMNI_POINT>(arg0, 9, b"BITOP", b"Bitomni Points", b"Bitomni Points", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/128760136?s=200&v=4"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOMNI_POINT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOMNI_POINT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BITOMNI_POINT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BITOMNI_POINT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

