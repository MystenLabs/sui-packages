module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::username_validation_rule {
    struct UsernameValidationRule has drop {
        dummy_field: bool,
    }

    struct Config has store {
        min_length: u64,
        max_length: u64,
    }

    public fun add(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::CreateUsernameOp>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = UsernameValidationRule{dummy_field: false};
        let v1 = Config{
            min_length : arg2,
            max_length : arg3,
        };
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::add<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::CreateUsernameOp, UsernameValidationRule, Config>(v0, arg0, arg1, v1, arg4);
    }

    public fun remove(arg0: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::CreateUsernameOp>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap) {
        let Config {
            min_length : _,
            max_length : _,
        } = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::remove<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::CreateUsernameOp, UsernameValidationRule, Config>(arg0, arg1);
    }

    public fun prove(arg0: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::CreateUsernameOp>, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::CreateUsernameTicket, arg2: &mut 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::CreateUsernameOp>) {
        assert!(0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::ticket_key(arg1) == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::request_key<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::CreateUsernameOp>(arg2), 4);
        let v0 = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::config<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::CreateUsernameOp, UsernameValidationRule, Config>(arg0);
        let v1 = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::ticket_name(arg1);
        let v2 = 0x1::string::as_bytes(&v1);
        let v3 = 0x1::vector::length<u8>(v2);
        assert!(v3 >= v0.min_length, 0);
        assert!(v3 <= v0.max_length, 1);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = *0x1::vector::borrow<u8>(v2, v4);
            let v6 = if (v5 >= 97 && v5 <= 122) {
                true
            } else if (v5 >= 48 && v5 <= 57) {
                true
            } else if (v5 == 95) {
                true
            } else {
                v5 == 45
            };
            assert!(v6, 2);
            v4 = v4 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(v2, 0) != 95 && *0x1::vector::borrow<u8>(v2, 0) != 45, 3);
        let v7 = UsernameValidationRule{dummy_field: false};
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::add_approval<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::CreateUsernameOp, UsernameValidationRule>(v7, arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

