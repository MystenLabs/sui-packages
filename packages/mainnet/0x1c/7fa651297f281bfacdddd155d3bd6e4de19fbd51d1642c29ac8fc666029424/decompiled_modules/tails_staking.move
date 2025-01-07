module 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::tails_staking {
    struct NftExtension has store, key {
        id: 0x2::object::UID,
        nft_table: 0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
        nft_manager_cap: 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap,
        policy: 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TransferNftEvent has copy, drop {
        sender: address,
        receiver: address,
        nft_id: 0x2::object::ID,
        number: u64,
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

    public fun migrate_nft_extension(arg0: &mut 0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::Registry, arg1: &0xa76499eda1d37751473de5f30e106f35943ada2f6ea764861243e7f5aa5bcc97::typus_dov_single::ManagerCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::object_table::ObjectTable<address, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, 0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::ManagerCap, 0x2::transfer_policy::TransferPolicy<0xbd147bc7f12f38f175d78947a61364e8e077b9b188b00e7094bc0c3623162196::typus_nft::Tails>, 0x2::coin::Coin<0x2::sui::SUI>) {
        abort 999
    }

    // decompiled from Move bytecode v6
}

