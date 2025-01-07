module 0x9dcdee88196a5d51d9a940b242d776f5750186d5bac4c5b7788b7ad9e58269c5::suisolpe {
    struct SUISOLPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISOLPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISOLPE>(arg0, 6, b"SUISOLPE", b"SOLPE", b"$SOLPE is a frog living in SUI,Already negotiated airdrop entry with three communities,This is the first step for $SOLPE to be recognized by everyone,Let's keep going!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wp_Fgr_V56_400x400_dc9db2cdd5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISOLPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISOLPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

