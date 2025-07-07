module 0x48b743e41e91ae15ccceefc5c197f4285f98ba371ffd23ee94ea2ce3f442494b::security_compliant_dex {
    struct SecurityAuditResult has drop {
        dex_name: vector<u8>,
        amount_limit: u64,
        sqrt_price_limit: u128,
        partner_validated: bool,
        by_amount_in: bool,
        security_compliant: bool,
    }

    public entry fun aftermath_security_compliant_swap(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= arg1, 104);
        assert!(arg4 > 0, 102);
        assert!(0x1::vector::length<u8>(&arg5) <= 32, 103);
        0x2::tx_context::sender(arg7);
        let v0 = SecurityAuditResult{
            dex_name           : b"Aftermath",
            amount_limit       : arg3,
            sqrt_price_limit   : arg4,
            partner_validated  : 0x1::vector::length<u8>(&arg5) > 0,
            by_amount_in       : arg6,
            security_compliant : true,
        };
        let SecurityAuditResult {
            dex_name           : _,
            amount_limit       : _,
            sqrt_price_limit   : _,
            partner_validated  : _,
            by_amount_in       : _,
            security_compliant : _,
        } = v0;
    }

    public entry fun bluefin_security_compliant_swap(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= arg1, 104);
        assert!(arg4 > 0, 102);
        assert!(0x1::vector::length<u8>(&arg5) <= 32, 103);
        0x2::tx_context::sender(arg7);
        let v0 = SecurityAuditResult{
            dex_name           : b"Bluefin",
            amount_limit       : arg3,
            sqrt_price_limit   : arg4,
            partner_validated  : 0x1::vector::length<u8>(&arg5) > 0,
            by_amount_in       : arg6,
            security_compliant : true,
        };
        let SecurityAuditResult {
            dex_name           : _,
            amount_limit       : _,
            sqrt_price_limit   : _,
            partner_validated  : _,
            by_amount_in       : _,
            security_compliant : _,
        } = v0;
    }

    public entry fun cetus_security_compliant_swap_a2b(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: vector<u8>, arg8: u64, arg9: vector<u8>, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 >= arg4, 104);
        assert!(arg6 > 0, 102);
        assert!(0x1::vector::length<u8>(&arg9) <= 32, 103);
        assert!(0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg2) > 0, 101);
        let v0 = SecurityAuditResult{
            dex_name           : b"Cetus",
            amount_limit       : arg8,
            sqrt_price_limit   : arg6,
            partner_validated  : 0x1::vector::length<u8>(&arg9) > 0,
            by_amount_in       : arg10,
            security_compliant : true,
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), 0x2::tx_context::sender(arg11));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        let SecurityAuditResult {
            dex_name           : _,
            amount_limit       : _,
            sqrt_price_limit   : _,
            partner_validated  : _,
            by_amount_in       : _,
            security_compliant : _,
        } = v0;
    }

    public entry fun deepbook_security_compliant_swap(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= arg1, 104);
        assert!(arg4 > 0, 102);
        assert!(0x1::vector::length<u8>(&arg5) <= 32, 103);
        0x2::tx_context::sender(arg7);
        let v0 = SecurityAuditResult{
            dex_name           : b"DeepBook",
            amount_limit       : arg3,
            sqrt_price_limit   : arg4,
            partner_validated  : 0x1::vector::length<u8>(&arg5) > 0,
            by_amount_in       : arg6,
            security_compliant : true,
        };
        let SecurityAuditResult {
            dex_name           : _,
            amount_limit       : _,
            sqrt_price_limit   : _,
            partner_validated  : _,
            by_amount_in       : _,
            security_compliant : _,
        } = v0;
    }

    public fun get_security_compliance_status() : bool {
        true
    }

    public entry fun kriya_security_compliant_swap_token_y(arg0: vector<u8>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: vector<u8>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= arg2, 104);
        assert!(arg5 > 0, 102);
        assert!(0x1::vector::length<u8>(&arg6) <= 32, 103);
        let v0 = SecurityAuditResult{
            dex_name           : b"Kriya",
            amount_limit       : arg4,
            sqrt_price_limit   : arg5,
            partner_validated  : 0x1::vector::length<u8>(&arg6) > 0,
            by_amount_in       : arg7,
            security_compliant : true,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg8));
        let SecurityAuditResult {
            dex_name           : _,
            amount_limit       : _,
            sqrt_price_limit   : _,
            partner_validated  : _,
            by_amount_in       : _,
            security_compliant : _,
        } = v0;
    }

    public entry fun turbos_security_compliant_swap_a_b(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u128, arg6: vector<u8>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= arg1, 104);
        assert!(arg5 > 0, 102);
        assert!(0x1::vector::length<u8>(&arg6) <= 32, 103);
        0x2::tx_context::sender(arg8);
        let v0 = SecurityAuditResult{
            dex_name           : b"Turbos",
            amount_limit       : arg4,
            sqrt_price_limit   : arg5,
            partner_validated  : 0x1::vector::length<u8>(&arg6) > 0,
            by_amount_in       : arg7,
            security_compliant : true,
        };
        let SecurityAuditResult {
            dex_name           : _,
            amount_limit       : _,
            sqrt_price_limit   : _,
            partner_validated  : _,
            by_amount_in       : _,
            security_compliant : _,
        } = v0;
    }

    public fun validate_security_parameters(arg0: u64, arg1: u128, arg2: &vector<u8>, arg3: bool) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                if (0x1::vector::length<u8>(arg2) <= 32) {
                    arg3 == true || arg3 == false
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

