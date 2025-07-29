module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_protocol {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct BlizzardStaking<phantom T0> has key {
        id: 0x2::object::UID,
    }

    public fun new<T0>(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard::BLIZZARD>, arg3: 0x2::coin::TreasuryCap<T0>, arg4: address, arg5: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = BlizzardStaking<T0>{id: 0x2::object::new(arg6)};
        let v1 = Key{dummy_field: false};
        0x2::dynamic_object_field::add<Key, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::BlizzardStateV1<T0>>(&mut v0.id, v1, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::new_state_v1<T0>(arg0, 0x2::object::uid_to_address(&v0.id), arg1, arg3, arg4, arg5, arg6));
        0x2::transfer::share_object<BlizzardStaking<T0>>(v0);
    }

    public fun add_node<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg2: 0x2::object::ID, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::add_node<T0>(state_mut<T0>(arg0), arg2, arg3, arg4);
    }

    public fun allowed_nodes<T0>(arg0: &mut BlizzardStaking<T0>) : vector<0x2::object::ID> {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::allowed_nodes<T0>(state<T0>(arg0))
    }

    public fun burn_lst<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::coin::Coin<T0>, arg3: vector<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::IX>, arg4: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::burn_lst<T0>(state_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public fun burn_stake_nft<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_stake_nft::BlizzardStakeNFT, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::burn_stake_nft<T0>(state_mut<T0>(arg0), arg1, arg2, arg3, arg4)
    }

    public fun claim_fees<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, 0x2::coin::Coin<T0>) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::claim_fees<T0>(state_mut<T0>(arg0), arg2, arg3)
    }

    public fun claim_protocol_fees<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard::BLIZZARD>, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, 0x2::coin::Coin<T0>) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::claim_protocol_fees<T0>(state_mut<T0>(arg0), arg2, arg3)
    }

    public fun fee_config<T0>(arg0: &mut BlizzardStaking<T0>) : &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::BlizzardFee {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::fee_config<T0>(state<T0>(arg0))
    }

    public fun mint<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: 0x2::object::ID, arg4: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::mint<T0>(state_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public fun mint_after_votes_finished<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: 0x2::object::ID, arg4: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_stake_nft::BlizzardStakeNFT {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::mint_after_votes_finished<T0>(state_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public fun pause<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::pause<T0>(state_mut<T0>(arg0), arg2);
    }

    public fun remove_node<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg2: 0x2::object::ID, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::remove_node<T0>(state_mut<T0>(arg0), arg2, arg3, arg4);
    }

    public fun set_burn_fee<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg2: u64, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::set_burn_fee<T0>(state_mut<T0>(arg0), arg2, arg3);
    }

    public fun set_mint_fee<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg2: u64, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::set_mint_fee<T0>(state_mut<T0>(arg0), arg2, arg3);
    }

    public fun set_protocol_fee<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard::BLIZZARD>, arg2: u64, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::set_protocol_fee<T0>(state_mut<T0>(arg0), arg2, arg3);
    }

    public fun set_transmute_fee<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg2: u64, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::set_transmute_fee<T0>(state_mut<T0>(arg0), arg2, arg3);
    }

    public fun staked_wal_vector_at_node<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x2::object::ID) : &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::BigVector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal> {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::staked_wal_vector_at_node<T0>(state<T0>(arg0), arg1)
    }

    public fun sync_exchange_rate<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::sync_exchange_rate<T0>(state_mut<T0>(arg0), arg1);
    }

    public fun sync_node_exchange_rate<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::object::ID) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::sync_node_exchange_rate<T0>(state_mut<T0>(arg0), arg1, arg2);
    }

    public fun to_lst_at_epoch<T0>(arg0: &mut BlizzardStaking<T0>, arg1: u32, arg2: u64, arg3: bool) : 0x1::option::Option<u64> {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::to_lst_at_epoch<T0>(state<T0>(arg0), arg1, arg2, arg3)
    }

    public fun to_wal_at_epoch<T0>(arg0: &mut BlizzardStaking<T0>, arg1: u32, arg2: u64, arg3: bool) : 0x1::option::Option<u64> {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::to_wal_at_epoch<T0>(state<T0>(arg0), arg1, arg2, arg3)
    }

    public fun transmute<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &mut BlizzardStaking<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: 0x2::coin::Coin<T0>, arg4: vector<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::IX>, arg5: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::transmute<T0>(state_mut<T0>(arg0), state_mut<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(arg1), arg2, arg3, arg4, arg5, arg6)
    }

    public fun unpause<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::unpause<T0>(state_mut<T0>(arg0), arg2);
    }

    public fun update_description<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg3: 0x1::string::String, arg4: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::update_description<T0>(state_mut<T0>(arg0), arg1, arg3, arg4);
    }

    public fun update_icon_url<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg3: 0x1::ascii::String, arg4: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::update_icon_url<T0>(state_mut<T0>(arg0), arg1, arg3, arg4);
    }

    public fun update_name<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg3: 0x1::string::String, arg4: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::update_name<T0>(state_mut<T0>(arg0), arg1, arg3, arg4);
    }

    public fun update_symbol<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<T0>, arg3: 0x1::ascii::String, arg4: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::update_symbol<T0>(state_mut<T0>(arg0), arg1, arg3, arg4);
    }

    public fun forceful_pause<T0>(arg0: &mut BlizzardStaking<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard::BLIZZARD>, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::pause<T0>(state_mut<T0>(arg0), arg2);
    }

    fun state<T0>(arg0: &mut BlizzardStaking<T0>) : &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::BlizzardStateV1<T0> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_object_field::borrow<Key, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::BlizzardStateV1<T0>>(&arg0.id, v0)
    }

    fun state_mut<T0>(arg0: &mut BlizzardStaking<T0>) : &mut 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::BlizzardStateV1<T0> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<Key, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol::BlizzardStateV1<T0>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

