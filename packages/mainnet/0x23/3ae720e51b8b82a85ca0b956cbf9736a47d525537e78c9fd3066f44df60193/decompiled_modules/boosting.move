module 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::boosting {
    struct PreSubscribe has key {
        id: 0x2::object::UID,
        paused: bool,
        start_time: u64,
        duration: u64,
        price_per_class: 0x2::table::Table<u8, u64>,
        fee_type: 0x1::type_name::TypeName,
        subscribers: 0x2::vec_set::VecSet<address>,
        subscribers_type: 0x2::table::Table<u8, 0x2::vec_set::VecSet<address>>,
        no_slots: 0x2::table::Table<u8, u16>,
    }

    struct InitPreSubscribeEvent has copy, drop {
        pre_subscribe: 0x2::object::ID,
    }

    struct PreSubscribeEvent has copy, drop {
        subscriber: address,
        type: u8,
        amount: u64,
    }

    struct BuyingStarEvent has copy, drop {
        buyer: address,
        number_of_stars: u64,
        fee: u64,
        nonce: u128,
    }

    struct SwappingStarEvent has copy, drop {
        swapper: address,
        number_of_stars: u64,
        received_fee: u64,
        nonce: u128,
    }

    struct SubscriptionEvent has copy, drop {
        subscriber: address,
        duration: u16,
        fee: u64,
        class: u8,
        nonce: u128,
    }

    struct CommissionClaimEvent has copy, drop {
        claimer: address,
        amount: u64,
        min_time: u64,
        max_time: u64,
        nonce: u128,
    }

    struct ClaimBonusEvent has copy, drop {
        claimer: address,
        amount: u64,
        min_time: u64,
        max_time: u64,
        nonce: u128,
    }

    public fun buying_stars<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::GlobalVault, arg2: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::UserArchive, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 7010
    }

    public fun change_fee_type_pre_subscribe<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut PreSubscribe) {
        abort 7010
    }

    public fun claim_bonus<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::GlobalVault, arg2: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::UserArchive, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 7010
    }

    public fun claim_commission<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::GlobalVault, arg2: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::UserArchive, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 7010
    }

    public fun deposit_fund_to_vault<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::TreasureCap, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::GlobalVault, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        abort 7010
    }

    public fun init_pre_subscribe<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut 0x2::tx_context::TxContext) {
        abort 7010
    }

    public fun migrate(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: u64) {
        abort 7010
    }

    public fun pause_pre_subscribe(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut PreSubscribe, arg3: bool) {
        abort 7010
    }

    public fun paused(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: bool) {
        abort 7010
    }

    public fun pre_subscribe<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg1: &mut PreSubscribe, arg2: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::GlobalVault, arg3: u8, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 7010
    }

    public fun register(arg0: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Logs, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::UserArchive {
        abort 7010
    }

    public fun set_duration_pre_subscribe(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut PreSubscribe, arg3: u64) {
        abort 7010
    }

    public fun set_fund_receiver(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::TreasureCap, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: address) {
        abort 7010
    }

    public fun set_no_slots_pre_subscribe(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut PreSubscribe, arg3: u8, arg4: u16) {
        abort 7010
    }

    public fun set_price_per_class_pre_subscribe(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut PreSubscribe, arg3: u8, arg4: u64) {
        abort 7010
    }

    public fun set_start_time_pre_subscribe(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::AdminCap, arg1: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut PreSubscribe, arg3: u64, arg4: &0x2::clock::Clock) {
        abort 7010
    }

    public fun subscribe<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::GlobalVault, arg2: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::UserArchive, arg3: u16, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::balance::Balance<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 7010
    }

    public fun swap_stars<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg1: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::GlobalVault, arg2: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::UserArchive, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 7010
    }

    public fun withdraw_all_from_vault<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::TreasureCap, arg1: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::GlobalVault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 7010
    }

    public fun withdraw_amount_from_vault<T0>(arg0: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::TreasureCap, arg1: &0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::Config, arg2: &mut 0x233ae720e51b8b82a85ca0b956cbf9736a47d525537e78c9fd3066f44df60193::guild::GlobalVault, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 7010
    }

    // decompiled from Move bytecode v6
}

