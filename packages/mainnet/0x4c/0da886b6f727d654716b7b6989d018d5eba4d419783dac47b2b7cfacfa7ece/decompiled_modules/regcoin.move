module 0x4c0da886b6f727d654716b7b6989d018d5eba4d419783dac47b2b7cfacfa7ece::regcoin {
    struct REGCOIN has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<REGCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<REGCOIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: REGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<REGCOIN>(arg0, 6, b"REGCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGCOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<REGCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REGCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<REGCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

