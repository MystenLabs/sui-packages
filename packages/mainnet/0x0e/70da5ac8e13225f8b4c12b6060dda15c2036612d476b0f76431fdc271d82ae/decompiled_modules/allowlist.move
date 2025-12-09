module 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::allowlist {
    struct AllowlistState has store, key {
        id: 0x2::object::UID,
        allowlist_enabled: bool,
        allowlist: vector<address>,
    }

    struct AllowlistRemove has copy, drop {
        sender: address,
    }

    struct AllowlistAdd has copy, drop {
        sender: address,
    }

    public fun new(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : AllowlistState {
        AllowlistState{
            id                : 0x2::object::new(arg1),
            allowlist_enabled : !0x1::vector::is_empty<address>(&arg0),
            allowlist         : arg0,
        }
    }

    public fun apply_allowlist_updates(arg0: &mut AllowlistState, arg1: vector<address>, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::borrow<address>(&arg1, v0);
            let (v2, v3) = 0x1::vector::index_of<address>(&arg0.allowlist, v1);
            if (v2) {
                0x1::vector::swap_remove<address>(&mut arg0.allowlist, v3);
                let v4 = AllowlistRemove{sender: *v1};
                0x2::event::emit<AllowlistRemove>(v4);
            };
            v0 = v0 + 1;
        };
        if (!0x1::vector::is_empty<address>(&arg2)) {
            assert!(arg0.allowlist_enabled, 1);
            v0 = 0;
            while (v0 < 0x1::vector::length<address>(&arg2)) {
                let v5 = 0x1::vector::borrow<address>(&arg2, v0);
                let (v6, _) = 0x1::vector::index_of<address>(&arg0.allowlist, v5);
                let v8 = @0x0;
                if (v5 != &v8 && !v6) {
                    0x1::vector::push_back<address>(&mut arg0.allowlist, *v5);
                    let v9 = AllowlistAdd{sender: *v5};
                    0x2::event::emit<AllowlistAdd>(v9);
                };
                v0 = v0 + 1;
            };
        };
    }

    public fun destroy_allowlist(arg0: AllowlistState) {
        let AllowlistState {
            id                : v0,
            allowlist_enabled : _,
            allowlist         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_allowlist(arg0: &AllowlistState) : vector<address> {
        arg0.allowlist
    }

    public fun get_allowlist_enabled(arg0: &AllowlistState) : bool {
        arg0.allowlist_enabled
    }

    public fun is_allowed(arg0: &AllowlistState, arg1: address) : bool {
        if (!arg0.allowlist_enabled) {
            return true
        };
        0x1::vector::contains<address>(&arg0.allowlist, &arg1)
    }

    public fun set_allowlist_enabled(arg0: &mut AllowlistState, arg1: bool) {
        arg0.allowlist_enabled = arg1;
    }

    // decompiled from Move bytecode v6
}

