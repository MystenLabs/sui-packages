module 0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet {
    struct LogicUpgraded has copy, drop {
        old_version: u64,
        new_version: u64,
        new_logic_id: 0x2::object::ID,
    }

    public fun authorize_upgrade(arg0: &mut 0x2::package::UpgradeCap, arg1: u8, arg2: vector<u8>) : 0x2::package::UpgradeTicket {
        0x2::package::authorize_upgrade(arg0, arg1, arg2)
    }

    public fun commit_upgrade(arg0: &mut 0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::WalletState, arg1: &mut 0x2::package::UpgradeCap, arg2: 0x2::package::UpgradeReceipt) {
        let v0 = 0x2::package::receipt_package(&arg2);
        0x2::package::commit_upgrade(arg1, arg2);
        let v1 = 0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::get_version(arg0);
        let v2 = v1 + 1;
        0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::set_version(arg0, v2);
        0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::set_logic_id(arg0, v0);
        let v3 = LogicUpgraded{
            old_version  : v1,
            new_version  : v2,
            new_logic_id : v0,
        };
        0x2::event::emit<LogicUpgraded>(v3);
    }

    public entry fun batch_register_wallets(arg0: &0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::WalletAdminCap, arg1: &mut 0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::WalletState, arg2: vector<vector<u8>>, arg3: vector<address>, arg4: vector<vector<u8>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) <= 50, 2);
        0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::batch_register_wallets(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::WalletAdminCap>(0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::new_wallet_admin_cap(arg0), 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::WalletState>(0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::new_wallet_state(arg0));
    }

    public entry fun register_wallet(arg0: &0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::WalletAdminCap, arg1: &mut 0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::WalletState, arg2: vector<u8>, arg3: address, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xde5031abdae03e4f2b486f50c063a38ae7b553994b99bccdc53734650635b364::drife_wallet_logic_v1::register_wallet(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

