module 0x858c2819323fb8a4415bf0f8e770595503e10b89dbb3e27c0bae60628191f5c1::cata {
    struct CATA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CATA>, arg1: 0x2::coin::Coin<CATA>) {
        0x2::coin::burn<CATA>(arg0, arg1);
    }

    fun init(arg0: CATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATA>(arg0, 9, b"$CATA", b"CATA Sui", b"CATA Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmeq3TSPLPwGM47yu7Ncq1dcnJapHNin7tahyY41eP8MrA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATA>(&mut v2, 2500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

