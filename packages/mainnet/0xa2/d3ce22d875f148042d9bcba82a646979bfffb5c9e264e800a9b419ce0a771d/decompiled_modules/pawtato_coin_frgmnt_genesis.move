module 0xa2d3ce22d875f148042d9bcba82a646979bfffb5c9e264e800a9b419ce0a771d::pawtato_coin_frgmnt_genesis {
    struct PAWTATO_COIN_FRGMNT_GENESIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_GENESIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_GENESIS>(arg0, 9, b"FRGMT_GENESIS", b"Pawtato Fragment of Genesis", b"This piece radiates the same pulse that awakened the first roots of Pawtato Land. It grants the bearer a touch of creation itself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-genesis.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_GENESIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_GENESIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

