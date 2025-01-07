module 0x7157770d020a828564ecdfe193b3afa7f563f483d628bd2fca8decefebd4f320::scallop_wormhole_sol {
    struct SCALLOP_WORMHOLE_SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_WORMHOLE_SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_WORMHOLE_SOL>(arg0, 8, b"sWSOL", b"sWSOL", b"Scallop interest-bearing token for wormhole SOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://5cmmqaoxbqgsavcuyd3ed3qnhfgzmfl3fnrn7woc5hncp53kwvxa.arweave.net/6JjIAdcMDSBUVMD2Qe4NOU2WFXsrYt_ZwunaJ_dqtW4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_WORMHOLE_SOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_WORMHOLE_SOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

