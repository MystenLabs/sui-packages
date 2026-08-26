module 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::main {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::new(arg0);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::priority_fee_vault::new(arg0);
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::allow_address(&mut v3, &mut v2, 0x2::tx_context::sender(arg0));
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::agent_registry::share_registry(0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::agent_registry::new(arg0));
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::share(0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::new(arg0));
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::share(v3);
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::priority_fee_vault::share(v4);
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::send_admin_cap_to_sender(v2, arg0);
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_slashing::send_cap_to_sender(0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_slashing::new(arg0), arg0);
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::priority_fee_vault::send_owner_cap_to_sender(v5, arg0);
    }

    // decompiled from Move bytecode v7
}

