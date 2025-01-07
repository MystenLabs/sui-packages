module 0x2918cf3a396aefe36bd65a16b7918f998f9c6d5da23c90120e9c8f5bfc6a7f59::chico {
    struct CHICO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICO>(arg0, 9, b"CHICO", b"Side Eye Dog", b"Chico the Side Eye Dog is coming to take over the SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2xWeKP4qq4pd8jyWm1kLvT3ei847AY5MTFVhwn2qpump.png?size=xl&key=a9fd05")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHICO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHICO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

