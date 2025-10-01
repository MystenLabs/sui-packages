module 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::sui_staking_smart_contract {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::create_and_share_staking_contract(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::create_and_transfer_admin_cap(0x2::tx_context::sender(arg0), arg0), arg0);
    }

    entry fun migrate_staking_contract(arg0: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg1: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap) {
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_staking_contract_admin(arg0) == 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::get_admin_cap_id(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_ENotAdmin());
        let v0 = 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_staking_contract_version_mut(arg0);
        assert!(*v0 < 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_VERSION(), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_ENotUpgrade());
        *v0 = 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_VERSION();
    }

    public fun mint_admin_cap(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::new_admin_cap(arg1)
    }

    // decompiled from Move bytecode v6
}

