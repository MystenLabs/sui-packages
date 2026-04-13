module 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::main {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::leader::new(0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::leader_cap::new(arg0), arg0);
        let v2 = v1;
        let v3 = v0;
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::leader::allow_address(&mut v3, &mut v2, 0x2::tx_context::sender(arg0));
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::default_tap::share(0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::default_tap::new(arg0));
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::tool_registry::share(0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::tool_registry::new(arg0));
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::share(0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::new_service(arg0));
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::network_auth::share(0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::network_auth::new(arg0));
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::leader::share(v3);
        let v4 = 0x2::party::single_owner(0x2::tx_context::sender(arg0));
        0x2::transfer::public_party_transfer<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::leader::LeaderCapabilitiesAdminCap>(v2, v4);
        0x2::transfer::public_party_transfer<0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::slashing::OverSlashing>>(0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::slashing::new(arg0), v4);
    }

    // decompiled from Move bytecode v6
}

