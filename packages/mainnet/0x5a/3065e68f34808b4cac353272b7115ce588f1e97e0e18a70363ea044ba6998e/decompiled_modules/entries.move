module 0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::entries {
    public entry fun burn(arg0: 0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT, arg1: &0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::VaultConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::burn(arg0, arg1, arg2);
    }

    public entry fun mint(arg0: &mut 0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::VaultConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::UserArchive, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>(0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun set_validator(arg0: &0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AdminCap, arg1: &mut 0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::VaultConfig, arg2: vector<u8>) {
        0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::set_validator(arg0, arg1, arg2);
    }

    public entry fun withdraw_fee(arg0: &0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AdminCap, arg1: &mut 0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::VaultConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::withdraw_fee(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

