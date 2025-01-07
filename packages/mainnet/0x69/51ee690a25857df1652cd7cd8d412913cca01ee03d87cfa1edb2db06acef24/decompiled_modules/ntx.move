module 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::ntx {
    struct NTX has drop {
        dummy_field: bool,
    }

    public fun add_admin<T0>(arg0: &mut 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::add_capability<T0, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::AdminCap>(arg0, arg1, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::new_admin_cap(), arg2);
    }

    public fun add_burner<T0>(arg0: &mut 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::add_capability<T0, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::BurnCap>(arg0, arg1, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::new_burn_cap(), arg2);
    }

    public fun add_minter<T0>(arg0: &mut 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::add_capability<T0, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::MintCap>(arg0, arg1, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::new_mint_cap(5000000, arg2), arg2);
    }

    public fun burn<T0>(arg0: &mut 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::ControlledTreasury<T0>, arg1: 0x2::token::Token<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::burn<T0>(arg0, arg1, arg2);
    }

    fun init(arg0: NTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTX>(arg0, 0, b"NTX", b"NTx Token", b"Loyalty Token for Xociety community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.xociety.io/assets/ntx/obj-ntx.png"))), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<NTX>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::new<NTX>(v2, 0x2::tx_context::sender(arg1), arg1);
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::add_capability<NTX, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::MintCap>(&mut v7, @0x32f70270061ebf412e63eb5f8fd1720cd77b554daca50bc0f6294e5da16779c0, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::new_mint_cap(5000000, arg1), arg1);
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::add_capability<NTX, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::WhitelistCap>(&mut v7, @0x32f70270061ebf412e63eb5f8fd1720cd77b554daca50bc0f6294e5da16779c0, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::new_whitelist_cap(), arg1);
        0x2::token::allow<NTX>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        let v8 = &mut v6;
        set_rules<NTX>(v8, &v5, arg1);
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::allowlist_rule::add_records<NTX>(&mut v6, &v5, vector[@0x32f70270061ebf412e63eb5f8fd1720cd77b554daca50bc0f6294e5da16779c0], arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTX>>(v1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<NTX>>(v5, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<NTX>(v6);
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::share<NTX>(v7);
    }

    public fun mint<T0>(arg0: &mut 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::ControlledTreasury<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::mint_and_transfer<T0>(arg0, arg2, arg1, arg3);
    }

    public fun remove_admin<T0>(arg0: &mut 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::remove_capability<T0, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::AdminCap>(arg0, arg1, arg2);
    }

    public fun remove_burner<T0>(arg0: &mut 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::remove_capability<T0, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::BurnCap>(arg0, arg1, arg2);
    }

    public fun remove_minter<T0>(arg0: &mut 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::ControlledTreasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::remove_capability<T0, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::treasury::MintCap>(arg0, arg1, arg2);
    }

    public(friend) fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, 0x6951ee690a25857df1652cd7cd8d412913cca01ee03d87cfa1edb2db06acef24::allowlist_rule::Allowlist>(arg0, arg1, 0x2::token::transfer_action(), arg2);
    }

    // decompiled from Move bytecode v6
}

