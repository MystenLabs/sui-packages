module 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tails_staking {
    struct NftExtension has store, key {
        id: 0x2::object::UID,
        nft_table: 0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
        nft_manager_cap: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap,
        policy: 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
    }

    struct StakeNftEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        ts_ms: u64,
    }

    struct UnstakeNftEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
    }

    struct TransferNftEvent has copy, drop {
        sender: address,
        receiver: address,
        nft_id: 0x2::object::ID,
        number: u64,
    }

    struct DailyAttendEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        ts_ms: u64,
        exp_earn: u64,
    }

    struct UpdateDepositEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        before: u64,
        after: u64,
    }

    struct SnapshotNftEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        ts_ms: u64,
        exp_earn: u64,
    }

    struct ClaimProfitSharingEvent has copy, drop {
        value: u64,
        token: 0x1::type_name::TypeName,
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        level: u64,
    }

    struct ClaimProfitSharingEventV2 has copy, drop {
        value: u64,
        token: 0x1::type_name::TypeName,
        sender: address,
        nft_id: 0x2::object::ID,
        number: u64,
        level: u64,
        name: 0x1::string::String,
    }

    struct ProfitSharing<phantom T0> has store {
        level_profits: vector<u64>,
        level_users: vector<u64>,
        total: u64,
        remaining: u64,
        pool: 0x2::balance::Balance<T0>,
    }

    struct ProfitSharingEvent has copy, drop {
        level_profits: vector<u64>,
        value: u64,
        token: 0x1::type_name::TypeName,
    }

    struct LevelUpEvent has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        sender: address,
        level: u64,
    }

    struct UpdateUrlEvent has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        level: u64,
        url: vector<u8>,
    }

    struct Partner has store, key {
        id: 0x2::object::UID,
        exp_allocation: u64,
        partner_traits: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct PartnerKey has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
        partner: 0x1::string::String,
    }

    public fun bid<T0, T1>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::tgld::TgldRegistry, arg3: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg4: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg5: u64, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt, 0x2::coin::Coin<T1>, vector<u64>) {
        abort 999
    }

    public fun compound<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt, vector<u64>) {
        abort 999
    }

    public entry fun consume_exp_coin_staked<T0>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        abort 999
    }

    public entry fun consume_exp_coin_unstaked<T0>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public fun deposit<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt, vector<u64>) {
        abort 999
    }

    public fun has_staked(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: address) : bool {
        abort 999
    }

    public fun migrate_nft_extension(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: 0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, arg2: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap, arg3: 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public fun migrate_typus_ecosystem_tails(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) : vector<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails> {
        abort 999
    }

    public fun new_bid<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt, vector<u64>) {
        abort 999
    }

    public fun new_bid_v2<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt, 0x2::coin::Coin<T1>, vector<u64>) {
        abort 999
    }

    public fun nft_exp_up(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg2: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun partner_add_exp(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &PartnerKey, arg2: address, arg3: u64) {
        abort 999
    }

    public fun reduce_usd_in_deposit(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    entry fun remove_exp_coin_extension<T0>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_registry_authority(arg0, arg1);
        let (v0, _, _, _, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, NftExtension>(v0, b"nft_extension").id, 0x1::string::utf8(b"exp_coin")), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun remove_nft_extension(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap, 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_registry_authority(arg0, arg1);
        let (v0, _, _, _, _, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg0);
        let NftExtension {
            id              : v12,
            nft_table       : v13,
            nft_manager_cap : v14,
            policy          : v15,
            fee             : v16,
        } = 0x2::dynamic_field::remove<vector<u8>, NftExtension>(v0, b"nft_extension");
        0x2::object::delete(v12);
        (v13, v14, v15, 0x2::coin::from_balance<0x2::sui::SUI>(v16, arg1))
    }

    public fun remove_nft_table_tails(arg0: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &mut 0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) : vector<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails> {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_registry_authority(arg0, arg3);
        let v0 = 0x1::vector::empty<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>();
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x1::vector::push_back<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(&mut v0, 0x2::object_table::remove<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>(arg1, 0x1::vector::pop_back<address>(&mut arg2)));
        };
        v0
    }

    public fun snapshot(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg2: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        abort 999
    }

    public entry fun stake_nft(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public entry fun switch_nft(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public entry fun transfer_nft(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public entry fun unstake_nft(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun unsubscribe<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt, vector<u64>) {
        abort 999
    }

    public fun withdraw<T0, T1>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusDepositReceipt>, vector<u64>) {
        abort 999
    }

    // decompiled from Move bytecode v6
}

