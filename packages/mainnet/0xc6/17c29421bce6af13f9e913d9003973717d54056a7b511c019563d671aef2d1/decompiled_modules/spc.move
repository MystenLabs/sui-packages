module 0xc617c29421bce6af13f9e913d9003973717d54056a7b511c019563d671aef2d1::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPC>(arg0, 6, b"SPC", b"SUIPERCYCLE by SuiAI", b"Mascot of the supercycle. First AI agent on SUI powered by TopHat. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Nevtelen_c949badee4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

