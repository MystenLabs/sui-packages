module 0x734a178da8dad8f04ea3569dcdbef2a5e7d3f40e235f21588edfd0794c715480::mtoken {
    struct TransferOwnershipEvent has copy, drop {
        old_owner: address,
        new_owner: address,
        et: u64,
        req_id: 0x2::object::ID,
    }

    struct SetOperatorEvent has copy, drop {
        old_operator: address,
        new_operator: address,
        et: u64,
        req_id: 0x2::object::ID,
    }

    struct SetRevokerEvent has copy, drop {
        old_revoker: address,
        new_revoker: address,
        et: u64,
        req_id: 0x2::object::ID,
    }

    struct SetDelayEvent has copy, drop {
        old_delay: u64,
        new_delay: u64,
        et: u64,
        req_id: 0x2::object::ID,
    }

    struct MintEvent has copy, drop {
        to_address: address,
        amount: u64,
        et: u64,
        req_id: 0x2::object::ID,
    }

    struct RedeemEvent has copy, drop {
        from_address: address,
        amount: u64,
    }

    struct BlockEvent has copy, drop {
        user_address: address,
    }

    struct UnblockEvent has copy, drop {
        user_address: address,
    }

    struct UpdateAnnualFeeRateEvent has copy, drop {
        annual_fee_rate: u64,
        oz_per_token_base: u64,
        oz_per_token_base_time: u64,
    }

    struct CCSendMintBudgetManuallyEvent has copy, drop {
        amount: u64,
    }

    struct CCReceiveMintBudgetManuallyEvent has copy, drop {
        amount: u64,
    }

    struct CCReceiveMintBudgetEvent has copy, drop {
        amount: u64,
    }

    struct CCReceiveTokenEvent has copy, drop {
        sender: vector<u8>,
        receiver: address,
        amount: u64,
    }

    struct CCBlockedTokenEvent has copy, drop {
        sender: vector<u8>,
        receiver: address,
        amount: u64,
    }

    struct CCSendMintBudgetEvent has copy, drop {
        amount: u64,
    }

    struct CCSendTokenEvent has copy, drop {
        sender: address,
        receiver: vector<u8>,
        amount: u64,
    }

    struct TransferOwnershipReq has key {
        id: 0x2::object::UID,
        new_owner: address,
        upgrade_cap: 0x2::package::UpgradeCap,
        et: u64,
    }

    struct SetOperatorReq has key {
        id: 0x2::object::UID,
        new_operator: address,
        et: u64,
    }

    struct SetRevokerReq has key {
        id: 0x2::object::UID,
        new_revoker: address,
        et: u64,
    }

    struct SetDelayReq has key {
        id: 0x2::object::UID,
        new_delay: u64,
        et: u64,
    }

    struct MintReq has key {
        id: 0x2::object::UID,
        recipient: address,
        amount: u64,
        expected_oz_per_token: u64,
        et: u64,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DenyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MessengerCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StateIdKey has copy, drop, store {
        dummy_field: bool,
    }

    struct State<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
        owner: address,
        operator: address,
        revoker: address,
        delay: u64,
        mint_budget: u64,
        oz_per_token_base_time: u64,
        oz_per_token_base: u64,
        annual_fee_rate: u64,
    }

    struct MessengerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun total_supply<T0>(arg0: &State<T0>) : u64 {
        0x2::coin::total_supply<T0>(borrow_treasury_cap<T0>(arg0))
    }

    entry fun update_description<T0>(arg0: &State<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        0x2::coin::update_description<T0>(borrow_treasury_cap<T0>(arg0), arg1, arg2);
    }

    entry fun update_icon_url<T0>(arg0: &State<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        0x2::coin::update_icon_url<T0>(borrow_treasury_cap<T0>(arg0), arg1, arg2);
    }

    entry fun add_to_blocked_list<T0>(arg0: &mut State<T0>, arg1: address, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg3);
        0x2::coin::deny_list_v2_add<T0>(arg2, borrow_deny_cap_mut<T0>(arg0), arg1, arg3);
        let v0 = BlockEvent{user_address: arg1};
        0x2::event::emit<BlockEvent>(v0);
    }

    public fun annual_fee_rate<T0>(arg0: &State<T0>) : u64 {
        arg0.annual_fee_rate
    }

    fun borrow_deny_cap_mut<T0>(arg0: &mut State<T0>) : &mut 0x2::coin::DenyCapV2<T0> {
        let v0 = DenyCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<DenyCapKey, 0x2::coin::DenyCapV2<T0>>(&mut arg0.id, v0)
    }

    fun borrow_treasury_cap<T0>(arg0: &State<T0>) : &0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0)
    }

    fun borrow_treasury_cap_mut<T0>(arg0: &mut State<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    entry fun cc_new_messenger_cap<T0>(arg0: &mut State<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg2);
        let v0 = MessengerCap{id: 0x2::object::new(arg2)};
        let v1 = MessengerCapKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<MessengerCapKey, 0x2::object::ID>(&mut arg0.id, v1);
        0x2::dynamic_field::add<MessengerCapKey, 0x2::object::ID>(&mut arg0.id, v1, 0x2::object::id<MessengerCap>(&v0));
        0x2::transfer::transfer<MessengerCap>(v0, arg1);
    }

    public fun cc_receive<T0>(arg0: &mut State<T0>, arg1: &MessengerCap, arg2: vector<u8>, arg3: &0x2::deny_list::DenyList, arg4: &mut 0x2::tx_context::TxContext) : (address, 0x1::option::Option<0x2::coin::Coin<T0>>) {
        check_version<T0>(arg0);
        check_messenger_cap<T0>(arg0, arg1);
        let v0 = 0x734a178da8dad8f04ea3569dcdbef2a5e7d3f40e235f21588edfd0794c715480::message_codec::decode_cc_message(arg2);
        if (0x734a178da8dad8f04ea3569dcdbef2a5e7d3f40e235f21588edfd0794c715480::message_codec::is_mint_budget(&v0)) {
            let v3 = 0x734a178da8dad8f04ea3569dcdbef2a5e7d3f40e235f21588edfd0794c715480::message_codec::extract_mint_budget(v0);
            arg0.mint_budget = arg0.mint_budget + v3;
            let v4 = CCReceiveMintBudgetEvent{amount: v3};
            0x2::event::emit<CCReceiveMintBudgetEvent>(v4);
            (@0x0, 0x1::option::none<0x2::coin::Coin<T0>>())
        } else {
            assert!(0x734a178da8dad8f04ea3569dcdbef2a5e7d3f40e235f21588edfd0794c715480::message_codec::is_token(&v0), 111);
            let (v5, v6, v7) = 0x734a178da8dad8f04ea3569dcdbef2a5e7d3f40e235f21588edfd0794c715480::message_codec::extract_token_info(v0);
            let v8 = if (!0x2::coin::deny_list_v2_contains_current_epoch<T0>(arg3, v6, arg4)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(borrow_treasury_cap_mut<T0>(arg0), v7, arg4), v6);
                let v9 = CCReceiveTokenEvent{
                    sender   : v5,
                    receiver : v6,
                    amount   : v7,
                };
                0x2::event::emit<CCReceiveTokenEvent>(v9);
                0x1::option::none<0x2::coin::Coin<T0>>()
            } else {
                let v10 = CCBlockedTokenEvent{
                    sender   : v5,
                    receiver : v6,
                    amount   : v7,
                };
                0x2::event::emit<CCBlockedTokenEvent>(v10);
                0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(borrow_treasury_cap_mut<T0>(arg0), v7, arg4))
            };
            (v6, v8)
        }
    }

    entry fun cc_receive_mint_budget_manually<T0>(arg0: &mut State<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_non_zero(arg1);
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg2);
        arg0.mint_budget = arg0.mint_budget + arg1;
        let v0 = CCReceiveMintBudgetManuallyEvent{amount: arg1};
        0x2::event::emit<CCReceiveMintBudgetManuallyEvent>(v0);
    }

    public fun cc_send_mint_budget<T0>(arg0: &mut State<T0>, arg1: &MessengerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<u8> {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg3);
        check_messenger_cap<T0>(arg0, arg1);
        check_non_zero(arg2);
        deduct_mint_budget<T0>(arg0, arg2);
        let v0 = CCSendMintBudgetEvent{amount: arg2};
        0x2::event::emit<CCSendMintBudgetEvent>(v0);
        msg_of_cc_send_mint_budget(arg2)
    }

    entry fun cc_send_mint_budget_manually<T0>(arg0: &mut State<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_non_zero(arg1);
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg2);
        deduct_mint_budget<T0>(arg0, arg1);
        let v0 = CCSendMintBudgetManuallyEvent{amount: arg1};
        0x2::event::emit<CCSendMintBudgetManuallyEvent>(v0);
    }

    public fun cc_send_token<T0>(arg0: &mut State<T0>, arg1: &MessengerCap, arg2: address, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        check_version<T0>(arg0);
        check_messenger_cap<T0>(arg0, arg1);
        check_non_zero(0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg4)));
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg4));
        0x2::coin::burn<T0>(borrow_treasury_cap_mut<T0>(arg0), arg4);
        let v1 = CCSendTokenEvent{
            sender   : arg2,
            receiver : arg3,
            amount   : v0,
        };
        0x2::event::emit<CCSendTokenEvent>(v1);
        msg_of_cc_send_token(arg2, arg3, v0)
    }

    fun check_annual_fee_rate(arg0: u64) {
        assert!(arg0 <= 100000000, 201);
    }

    fun check_effective_time(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        assert!(arg1 <= v0, 104);
        assert!(arg1 + 3600 > v0, 109);
    }

    fun check_messenger_cap<T0>(arg0: &State<T0>, arg1: &MessengerCap) {
        let v0 = MessengerCapKey{dummy_field: false};
        let v1 = 0x2::object::id<MessengerCap>(arg1);
        assert!(&v1 == 0x2::dynamic_field::borrow<MessengerCapKey, 0x2::object::ID>(&arg0.id, v0), 112);
    }

    fun check_non_zero(arg0: u64) {
        assert!(arg0 > 0, 115);
    }

    fun check_operator<T0>(arg0: &State<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 102);
    }

    fun check_owner<T0>(arg0: &State<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 101);
    }

    fun check_oz_per_token<T0>(arg0: &State<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(oz_per_token<T0>(arg0, arg2) == arg1, 205);
    }

    fun check_req<T0>(arg0: &State<T0>, arg1: &0x2::object::UID) {
        let v0 = StateIdKey{dummy_field: false};
        let v1 = 0x2::object::id<State<T0>>(arg0);
        assert!(0x2::dynamic_field::borrow<StateIdKey, 0x2::object::ID>(arg1, v0) == &v1, 116);
    }

    fun check_revoker<T0>(arg0: &State<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.revoker, 103);
    }

    fun check_version<T0>(arg0: &State<T0>) {
        assert!(arg0.version == 2, 100);
    }

    public fun create_coin<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: bool, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        let v3 = 0x2::tx_context::sender(arg8);
        let v4 = State<T0>{
            id                     : 0x2::object::new(arg8),
            version                : 2,
            upgrade_cap_id         : 0x1::option::none<0x2::object::ID>(),
            owner                  : v3,
            operator               : v3,
            revoker                : v3,
            delay                  : arg7,
            mint_budget            : 0,
            oz_per_token_base_time : 0,
            oz_per_token_base      : 0,
            annual_fee_rate        : 0,
        };
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v4.id, v5, v0);
        let v6 = DenyCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<DenyCapKey, 0x2::coin::DenyCapV2<T0>>(&mut v4.id, v6, v1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T0>>(v2);
        0x2::transfer::public_share_object<State<T0>>(v4);
    }

    fun current_day_start_time(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000 / 86400 * 86400
    }

    fun deduct_mint_budget<T0>(arg0: &mut State<T0>, arg1: u64) {
        assert!(arg0.mint_budget >= arg1, 106);
        arg0.mint_budget = arg0.mint_budget - arg1;
    }

    public fun delay<T0>(arg0: &State<T0>) : u64 {
        arg0.delay
    }

    entry fun execute_mint_to<T0>(arg0: &mut State<T0>, arg1: MintReq, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg3);
        check_req<T0>(arg0, &arg1.id);
        let MintReq {
            id                    : v0,
            recipient             : v1,
            amount                : v2,
            expected_oz_per_token : v3,
            et                    : v4,
        } = arg1;
        check_effective_time(arg2, v4);
        check_oz_per_token<T0>(arg0, v3, arg2);
        deduct_mint_budget<T0>(arg0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(borrow_treasury_cap_mut<T0>(arg0), v2, arg3), v1);
        0x2::object::delete(v0);
        let v5 = MintEvent{
            to_address : v1,
            amount     : v2,
            et         : 0,
            req_id     : 0x2::object::id<MintReq>(&arg1),
        };
        0x2::event::emit<MintEvent>(v5);
    }

    entry fun execute_set_delay<T0>(arg0: &mut State<T0>, arg1: SetDelayReq, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        check_req<T0>(arg0, &arg1.id);
        let SetDelayReq {
            id        : v0,
            new_delay : v1,
            et        : v2,
        } = arg1;
        check_effective_time(arg2, v2);
        arg0.delay = v1;
        0x2::object::delete(v0);
        let v3 = SetDelayEvent{
            old_delay : arg0.delay,
            new_delay : v1,
            et        : 0,
            req_id    : 0x2::object::id<SetDelayReq>(&arg1),
        };
        0x2::event::emit<SetDelayEvent>(v3);
    }

    entry fun execute_set_operator<T0>(arg0: &mut State<T0>, arg1: SetOperatorReq, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        check_req<T0>(arg0, &arg1.id);
        let SetOperatorReq {
            id           : v0,
            new_operator : v1,
            et           : v2,
        } = arg1;
        check_effective_time(arg2, v2);
        arg0.operator = v1;
        0x2::object::delete(v0);
        let v3 = SetOperatorEvent{
            old_operator : arg0.operator,
            new_operator : v1,
            et           : 0,
            req_id       : 0x2::object::id<SetOperatorReq>(&arg1),
        };
        0x2::event::emit<SetOperatorEvent>(v3);
    }

    entry fun execute_set_revoker<T0>(arg0: &mut State<T0>, arg1: SetRevokerReq, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        check_req<T0>(arg0, &arg1.id);
        let SetRevokerReq {
            id          : v0,
            new_revoker : v1,
            et          : v2,
        } = arg1;
        check_effective_time(arg2, v2);
        arg0.revoker = v1;
        0x2::object::delete(v0);
        let v3 = SetRevokerEvent{
            old_revoker : arg0.revoker,
            new_revoker : v1,
            et          : 0,
            req_id      : 0x2::object::id<SetRevokerReq>(&arg1),
        };
        0x2::event::emit<SetRevokerEvent>(v3);
    }

    entry fun execute_transfer_ownership<T0>(arg0: &mut State<T0>, arg1: TransferOwnershipReq, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_req<T0>(arg0, &arg1.id);
        assert!(0x2::tx_context::sender(arg3) == arg1.new_owner, 107);
        let TransferOwnershipReq {
            id          : v0,
            new_owner   : v1,
            upgrade_cap : v2,
            et          : v3,
        } = arg1;
        check_effective_time(arg2, v3);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(v2, v1);
        arg0.owner = v1;
        0x2::object::delete(v0);
        let v4 = TransferOwnershipEvent{
            old_owner : arg0.owner,
            new_owner : v1,
            et        : 0,
            req_id    : 0x2::object::id<TransferOwnershipReq>(&arg1),
        };
        0x2::event::emit<TransferOwnershipEvent>(v4);
    }

    fun get_effective_time<T0>(arg0: &State<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg1) / 1000 + arg0.delay
    }

    public fun get_oz_amount<T0>(arg0: &State<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        (((arg1 as u128) * (oz_per_token<T0>(arg0, arg2) as u128) / (1000000000 as u128)) as u64)
    }

    entry fun init_annual_fee_rate<T0>(arg0: &mut State<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_owner<T0>(arg0, arg4);
        check_annual_fee_rate(arg1);
        assert!(arg2 <= 1000000000, 204);
        assert!(arg0.oz_per_token_base_time == 0, 202);
        arg0.oz_per_token_base_time = current_day_start_time(arg3);
        arg0.oz_per_token_base = arg2;
        arg0.annual_fee_rate = arg1;
    }

    entry fun init_upgrade_cap_id<T0>(arg0: &mut State<T0>, arg1: &0x2::package::UpgradeCap, arg2: &0x2::tx_context::TxContext) {
        check_owner<T0>(arg0, arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.upgrade_cap_id), 110);
        let v0 = 0x2::package::upgrade_package(arg1);
        assert!(0x2::object::id_to_address(&v0) == package_address<T0>(arg0), 108);
        arg0.upgrade_cap_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::package::UpgradeCap>(arg1));
    }

    entry fun migrate<T0>(arg0: &mut State<T0>, arg1: &0x2::tx_context::TxContext) {
        check_owner<T0>(arg0, arg1);
        assert!(arg0.version < 2, 100);
        arg0.version = 2;
    }

    public fun mint_budget<T0>(arg0: &State<T0>) : u64 {
        arg0.mint_budget
    }

    public fun msg_of_cc_send_mint_budget(arg0: u64) : vector<u8> {
        0x734a178da8dad8f04ea3569dcdbef2a5e7d3f40e235f21588edfd0794c715480::message_codec::encode_cc_mint_budget_message(arg0)
    }

    public fun msg_of_cc_send_token(arg0: address, arg1: vector<u8>, arg2: u64) : vector<u8> {
        0x734a178da8dad8f04ea3569dcdbef2a5e7d3f40e235f21588edfd0794c715480::message_codec::encode_cc_token_message(arg0, arg1, arg2)
    }

    public fun operator<T0>(arg0: &State<T0>) : address {
        arg0.operator
    }

    public fun owner<T0>(arg0: &State<T0>) : address {
        arg0.owner
    }

    public fun oz_per_token<T0>(arg0: &State<T0>, arg1: &0x2::clock::Clock) : u64 {
        assert!(arg0.oz_per_token_base_time > 0, 203);
        arg0.oz_per_token_base - arg0.annual_fee_rate * (0x2::clock::timestamp_ms(arg1) / 1000 - arg0.oz_per_token_base_time) / 86400 / 365
    }

    public fun oz_per_token_base<T0>(arg0: &State<T0>) : u64 {
        arg0.oz_per_token_base
    }

    public fun oz_per_token_base_time<T0>(arg0: &State<T0>) : u64 {
        arg0.oz_per_token_base_time
    }

    public fun package_address<T0>(arg0: &State<T0>) : address {
        let v0 = 0x1::type_name::with_original_ids<State<T0>>();
        let v1 = 0x1::type_name::address_string(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    entry fun redeem<T0>(arg0: &mut State<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg4);
        check_oz_per_token<T0>(arg0, arg2, arg3);
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1));
        let v1 = borrow_treasury_cap_mut<T0>(arg0);
        0x2::coin::burn<T0>(v1, arg1);
        arg0.mint_budget = arg0.mint_budget + v0;
        let v2 = RedeemEvent{
            from_address : 0x2::tx_context::sender(arg4),
            amount       : v0,
        };
        0x2::event::emit<RedeemEvent>(v2);
    }

    entry fun remove_from_blocked_list<T0>(arg0: &mut State<T0>, arg1: address, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg3);
        0x2::coin::deny_list_v2_remove<T0>(arg2, borrow_deny_cap_mut<T0>(arg0), arg1, arg3);
        let v0 = UnblockEvent{user_address: arg1};
        0x2::event::emit<UnblockEvent>(v0);
    }

    entry fun request_mint_to<T0>(arg0: &State<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_operator<T0>(arg0, arg5);
        check_oz_per_token<T0>(arg0, arg3, arg4);
        let v0 = get_effective_time<T0>(arg0, arg4);
        let v1 = MintReq{
            id                    : 0x2::object::new(arg5),
            recipient             : arg1,
            amount                : arg2,
            expected_oz_per_token : arg3,
            et                    : v0,
        };
        let v2 = StateIdKey{dummy_field: false};
        0x2::dynamic_field::add<StateIdKey, 0x2::object::ID>(&mut v1.id, v2, 0x2::object::id<State<T0>>(arg0));
        0x2::transfer::share_object<MintReq>(v1);
        let v3 = MintEvent{
            to_address : arg1,
            amount     : arg2,
            et         : v0,
            req_id     : 0x2::object::id<MintReq>(&v1),
        };
        0x2::event::emit<MintEvent>(v3);
    }

    entry fun request_set_delay<T0>(arg0: &State<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        assert!(arg1 >= 3600, 105);
        assert!(arg1 <= 172800, 114);
        let v0 = get_effective_time<T0>(arg0, arg2);
        let v1 = SetDelayReq{
            id        : 0x2::object::new(arg3),
            new_delay : arg1,
            et        : v0,
        };
        let v2 = StateIdKey{dummy_field: false};
        0x2::dynamic_field::add<StateIdKey, 0x2::object::ID>(&mut v1.id, v2, 0x2::object::id<State<T0>>(arg0));
        0x2::transfer::share_object<SetDelayReq>(v1);
        let v3 = SetDelayEvent{
            old_delay : arg0.delay,
            new_delay : arg1,
            et        : v0,
            req_id    : 0x2::object::id<SetDelayReq>(&v1),
        };
        0x2::event::emit<SetDelayEvent>(v3);
    }

    entry fun request_set_operator<T0>(arg0: &State<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        let v0 = get_effective_time<T0>(arg0, arg2);
        let v1 = SetOperatorReq{
            id           : 0x2::object::new(arg3),
            new_operator : arg1,
            et           : v0,
        };
        let v2 = StateIdKey{dummy_field: false};
        0x2::dynamic_field::add<StateIdKey, 0x2::object::ID>(&mut v1.id, v2, 0x2::object::id<State<T0>>(arg0));
        0x2::transfer::share_object<SetOperatorReq>(v1);
        let v3 = SetOperatorEvent{
            old_operator : arg0.operator,
            new_operator : arg1,
            et           : v0,
            req_id       : 0x2::object::id<SetOperatorReq>(&v1),
        };
        0x2::event::emit<SetOperatorEvent>(v3);
    }

    entry fun request_set_revoker<T0>(arg0: &State<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        let v0 = get_effective_time<T0>(arg0, arg2);
        let v1 = SetRevokerReq{
            id          : 0x2::object::new(arg3),
            new_revoker : arg1,
            et          : v0,
        };
        let v2 = StateIdKey{dummy_field: false};
        0x2::dynamic_field::add<StateIdKey, 0x2::object::ID>(&mut v1.id, v2, 0x2::object::id<State<T0>>(arg0));
        0x2::transfer::share_object<SetRevokerReq>(v1);
        let v3 = SetRevokerEvent{
            old_revoker : arg0.revoker,
            new_revoker : arg1,
            et          : v0,
            req_id      : 0x2::object::id<SetRevokerReq>(&v1),
        };
        0x2::event::emit<SetRevokerEvent>(v3);
    }

    entry fun request_transfer_ownership<T0>(arg0: &State<T0>, arg1: address, arg2: 0x2::package::UpgradeCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg4);
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(&arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.upgrade_cap_id, &v0), 108);
        let v1 = get_effective_time<T0>(arg0, arg3);
        let v2 = TransferOwnershipReq{
            id          : 0x2::object::new(arg4),
            new_owner   : arg1,
            upgrade_cap : arg2,
            et          : v1,
        };
        let v3 = StateIdKey{dummy_field: false};
        0x2::dynamic_field::add<StateIdKey, 0x2::object::ID>(&mut v2.id, v3, 0x2::object::id<State<T0>>(arg0));
        let v4 = TransferOwnershipEvent{
            old_owner : arg0.owner,
            new_owner : arg1,
            et        : v1,
            req_id    : 0x2::object::id<TransferOwnershipReq>(&v2),
        };
        0x2::event::emit<TransferOwnershipEvent>(v4);
        0x2::transfer::share_object<TransferOwnershipReq>(v2);
    }

    entry fun revoke_mint_to<T0>(arg0: &State<T0>, arg1: MintReq, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_revoker<T0>(arg0, arg2);
        check_req<T0>(arg0, &arg1.id);
        let MintReq {
            id                    : v0,
            recipient             : _,
            amount                : _,
            expected_oz_per_token : _,
            et                    : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    entry fun revoke_set_delay<T0>(arg0: &State<T0>, arg1: SetDelayReq, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_revoker<T0>(arg0, arg2);
        check_req<T0>(arg0, &arg1.id);
        let SetDelayReq {
            id        : v0,
            new_delay : _,
            et        : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    entry fun revoke_set_operator<T0>(arg0: &State<T0>, arg1: SetOperatorReq, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_revoker<T0>(arg0, arg2);
        check_req<T0>(arg0, &arg1.id);
        let SetOperatorReq {
            id           : v0,
            new_operator : _,
            et           : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    entry fun revoke_set_revoker<T0>(arg0: &State<T0>, arg1: SetRevokerReq, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg2);
        check_req<T0>(arg0, &arg1.id);
        let SetRevokerReq {
            id          : v0,
            new_revoker : _,
            et          : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    entry fun revoke_transfer_ownership<T0>(arg0: &State<T0>, arg1: TransferOwnershipReq, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg2);
        check_req<T0>(arg0, &arg1.id);
        let TransferOwnershipReq {
            id          : v0,
            new_owner   : _,
            upgrade_cap : v2,
            et          : _,
        } = arg1;
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(v2, arg0.owner);
        0x2::object::delete(v0);
    }

    public fun revoker<T0>(arg0: &State<T0>) : address {
        arg0.revoker
    }

    entry fun update_annual_fee_rate<T0>(arg0: &mut State<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        check_owner<T0>(arg0, arg3);
        check_annual_fee_rate(arg1);
        assert!(arg0.oz_per_token_base_time > 0, 203);
        let v0 = oz_per_token<T0>(arg0, arg2);
        let v1 = current_day_start_time(arg2);
        arg0.annual_fee_rate = arg1;
        arg0.oz_per_token_base = v0;
        arg0.oz_per_token_base_time = v1;
        let v2 = UpdateAnnualFeeRateEvent{
            annual_fee_rate        : arg1,
            oz_per_token_base      : v0,
            oz_per_token_base_time : v1,
        };
        0x2::event::emit<UpdateAnnualFeeRateEvent>(v2);
    }

    public fun upgrade_cap_id<T0>(arg0: &State<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.upgrade_cap_id
    }

    public fun version<T0>(arg0: &State<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

