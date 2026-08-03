module 0x53800e9d7ef05777108c830edf8b89d9ae7d7e8a42be3a6ae575d44a73ef7473::lv_share {
    struct LV_SHARE has key {
        id: 0x2::object::UID,
    }

    fun clone_string(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(v0, v2));
            v2 = v2 + 1;
        };
        0x1::string::utf8(v1)
    }

    fun is_valid_name(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0 || v1 > 256) {
            return false
        };
        if (*0x1::vector::borrow<u8>(v0, 0) == 32 || *0x1::vector::borrow<u8>(v0, v1 - 1) == 32) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            if (v3 < 32 || v3 > 126) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun is_valid_symbol(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0 || v1 > 32) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = v2 == 0 || v2 == v1 - 1;
            let v5 = if (v3 >= 48 && v3 <= 57) {
                true
            } else if (v3 >= 65 && v3 <= 90) {
                true
            } else {
                v3 >= 97 && v3 <= 122
            };
            let v6 = if (v3 == 45) {
                true
            } else if (v3 == 46) {
                true
            } else {
                v3 == 95
            };
            let v7 = v4 && v5 || v5 || v6;
            if (!v7) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun register_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<LV_SHARE>, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_share_metadata::ShareRegistrationProof) {
        assert!(!0x2::coin_registry::exists<LV_SHARE>(arg0), 13906834320372269055);
        assert!(is_valid_name(&arg1) && is_valid_symbol(&arg2), 1);
        let (v0, v1) = 0x2::coin_registry::new_currency<LV_SHARE>(arg0, 6, arg2, arg1, 0x1::string::utf8(b"Splyce Concord lending vault share"), 0x1::string::utf8(b"https://splyce.fi"), arg3);
        let v2 = v1;
        0x2::coin_registry::finalize_and_delete_metadata_cap<LV_SHARE>(v0, arg3);
        (v2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault_factory::register_share_treasury(0x2::object::id<0x2::coin::TreasuryCap<LV_SHARE>>(&v2), clone_string(&arg1), clone_string(&arg2), arg3))
    }

    // decompiled from Move bytecode v7
}

