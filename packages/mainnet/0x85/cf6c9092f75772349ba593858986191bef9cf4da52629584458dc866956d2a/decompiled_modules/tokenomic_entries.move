module 0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic_entries {
    public entry fun addFund<T0>(arg0: &0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::TAdminCap, arg1: &mut 0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::TokenomicPie<T0>, arg2: address, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::version::Version, arg12: vector<u64>, arg13: vector<u64>, arg14: &mut 0x2::tx_context::TxContext) {
        0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::addFund<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public entry fun change_admin(arg0: 0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::TAdminCap, arg1: address, arg2: &mut 0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::version::Version) {
        0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::change_admin(arg0, arg1, arg2);
    }

    public entry fun change_fund_owner<T0>(arg0: &mut 0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::TokenomicPie<T0>, arg1: address, arg2: &mut 0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::change_fund_owner<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun claim<T0>(arg0: &mut 0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::TokenomicPie<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::claim<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun init_tokenomic<T0>(arg0: &0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::TAdminCap, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x65fc5f6bd596258ba47ef6e65c52322623237b5e82cbef747b42c309d6ac704b::tokenomic::init_tokenomic<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

