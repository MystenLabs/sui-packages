module 0xc6b2f19923f3c62ccc5d10c2247873d033128d0d056eba1d27cd29441b8b7f69::sepe {
    struct SEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEPE>(arg0, 6, b"SEPE", b"Sepe On Sui", b"$SEPE The next $PEPE on $SUI Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B1_EA_0_DE_7_E600_4900_A469_53_F9_F12_B61_F5_e535628238.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

