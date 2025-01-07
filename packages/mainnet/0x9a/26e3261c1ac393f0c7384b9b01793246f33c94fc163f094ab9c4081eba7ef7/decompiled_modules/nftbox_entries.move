module 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox_entries {
    public entry fun add_attribute<T0>(arg0: &0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftAdminCap, arg1: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>, arg2: u8, arg3: vector<u8>, arg4: vector<u8>) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::add_attribute<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun add_collection<T0>(arg0: &0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftAdminCap, arg1: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: vector<u8>, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::add_collection<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public entry fun add_whitelist<T0>(arg0: &0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftAdminCap, arg1: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>, arg2: vector<address>) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::add_whitelist<T0>(arg0, arg1, arg2);
    }

    public entry fun buy_nft<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: vector<u64>, arg3: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>, arg4: &0x2::clock::Clock, arg5: &0xd537ca3d976dde01617ecf4241c37b817038081928b7f922c4f13e3cb764f57c::kyc::Kyc, arg6: &mut 0x2::tx_context::TxContext) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::buy_nft<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun change_admin(arg0: 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftAdminCap, arg1: address) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::change_admin(arg0, arg1);
    }

    public entry fun change_treasury_admin(arg0: 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftTreasuryCap, arg1: address) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::change_treasury_admin(arg0, arg1);
    }

    public entry fun claim_nft<T0>(arg0: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::claim_nft<T0>(arg0, arg1, arg2);
    }

    public entry fun claim_refund<T0>(arg0: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::claim_refund<T0>(arg0, arg1, arg2);
    }

    public entry fun create_pool<T0>(arg0: &0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftAdminCap, arg1: address, arg2: u64, arg3: u8, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::create_pool<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun remove_collection<T0>(arg0: &0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftAdminCap, arg1: u8, arg2: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::remove_collection<T0>(arg0, arg1, arg2);
    }

    public entry fun remove_whitelist<T0>(arg0: &0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftAdminCap, arg1: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>, arg2: vector<address>) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::remove_whitelist<T0>(arg0, arg1, arg2);
    }

    public entry fun start_pool<T0>(arg0: &0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftAdminCap, arg1: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>, arg2: &0x2::clock::Clock) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::start_pool<T0>(arg0, arg1, arg2);
    }

    public entry fun withdraw_fund<T0>(arg0: &0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftTreasuryCap, arg1: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::withdraw_fund<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun stop_pool<T0>(arg0: &0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftAdminCap, arg1: &mut 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::NftPool<T0>, arg2: &0x2::clock::Clock) {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox::start_pool<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

