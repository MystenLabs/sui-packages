module 0xd35f1bdd4e4c86f5d6b72335ff4285833779b2181e170b2ee333843ee499f944::steamm_lp_brat_bmaya {
    struct STEAMM_LP_BRAT_BMAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BRAT_BMAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BRAT_BMAYA>(arg0, 9, b"STEAMM LP bRAT-bMAYA", b"STEAMM LP Token bRAT-bMAYA", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BRAT_BMAYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BRAT_BMAYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

