module 0xa44fd562158d39b39dda8c9ef4e7564df94d94cbb6f2055603cce32cbd611b30::automation {
    struct AutomationAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AutomationRegistry has key {
        id: 0x2::object::UID,
        automation_fee: u64,
        paused: bool,
        pending_payments: 0x2::table::Table<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        clients: vector<0x2::object::ID>,
    }

    struct Client has key {
        id: 0x2::object::UID,
        mode: u8,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        pending_withdrawal: u64,
        withdrawal_after: u64,
        next_deadline: u64,
        paused: bool,
        perform_target: 0x1::ascii::String,
        perform_args: vector<0x2::object::ID>,
        perform_data: vector<u8>,
    }

    struct PerformTicket {
        client_id: 0x2::object::ID,
    }

    struct ClientRegistered has copy, drop {
        client_id: 0x2::object::ID,
        owner: address,
        mode: u8,
    }

    struct UpkeepPerformed has copy, drop {
        client_id: 0x2::object::ID,
        performer: address,
        fee: u64,
    }

    struct WithdrawalRequested has copy, drop {
        client_id: 0x2::object::ID,
        amount: u64,
        after: u64,
    }

    struct WithdrawalExecuted has copy, drop {
        client_id: 0x2::object::ID,
        amount: u64,
    }

    struct KeeperPaid has copy, drop {
        keeper: address,
        amount: u64,
    }

    public fun add_funds(arg0: &mut Client, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun automation_fee(arg0: &AutomationRegistry) : u64 {
        arg0.automation_fee
    }

    public fun client_balance(arg0: &Client) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun client_count(arg0: &AutomationRegistry) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.clients)
    }

    public fun client_mode(arg0: &Client) : u8 {
        arg0.mode
    }

    public fun client_of(arg0: &AutomationRegistry, arg1: u64) : 0x2::object::ID {
        *0x1::vector::borrow<0x2::object::ID>(&arg0.clients, arg1)
    }

    public fun client_owner(arg0: &Client) : address {
        arg0.owner
    }

    public fun client_paused(arg0: &Client) : bool {
        arg0.paused
    }

    public fun consume_ticket(arg0: &Client, arg1: PerformTicket) {
        let PerformTicket { client_id: v0 } = arg1;
        assert!(v0 == 0x2::object::id<Client>(arg0), 9);
    }

    fun credit_keeper(arg0: &mut AutomationRegistry, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        if (0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.pending_payments, arg1)) {
            0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.pending_payments, arg1), 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        } else {
            0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.pending_payments, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        };
    }

    public fun execute_withdrawal(arg0: &mut Client, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        let v0 = arg0.pending_withdrawal;
        assert!(v0 > 0, 7);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.withdrawal_after, 8);
        assert!(v0 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 1);
        arg0.pending_withdrawal = 0;
        arg0.withdrawal_after = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg2), 0x2::tx_context::sender(arg2));
        let v1 = WithdrawalExecuted{
            client_id : 0x2::object::id<Client>(arg0),
            amount    : v0,
        };
        0x2::event::emit<WithdrawalExecuted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AutomationRegistry{
            id               : 0x2::object::new(arg0),
            automation_fee   : 50000000,
            paused           : false,
            pending_payments : 0x2::table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg0),
            clients          : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<AutomationRegistry>(v0);
        let v1 = AutomationAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AutomationAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &AutomationRegistry) : bool {
        arg0.paused
    }

    public fun next_deadline(arg0: &Client) : u64 {
        arg0.next_deadline
    }

    public fun payment_of(arg0: &AutomationRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.pending_payments, arg1)) {
            0x2::balance::value<0x2::sui::SUI>(0x2::table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.pending_payments, arg1))
        } else {
            0
        }
    }

    public fun perform(arg0: &mut AutomationRegistry, arg1: &mut Client, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : PerformTicket {
        assert!(!arg0.paused, 3);
        assert!(!arg1.paused, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg0.automation_fee, 1);
        if (arg1.mode == 1) {
            assert!(0x2::clock::timestamp_ms(arg2) >= arg1.next_deadline, 4);
        };
        let v0 = 0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg0.automation_fee, arg3);
        credit_keeper(arg0, 0x2::tx_context::sender(arg3), v0);
        let v1 = UpkeepPerformed{
            client_id : 0x2::object::id<Client>(arg1),
            performer : 0x2::tx_context::sender(arg3),
            fee       : arg0.automation_fee,
        };
        0x2::event::emit<UpkeepPerformed>(v1);
        PerformTicket{client_id: 0x2::object::id<Client>(arg1)}
    }

    public fun perform_args(arg0: &Client) : &vector<0x2::object::ID> {
        &arg0.perform_args
    }

    public fun perform_data(arg0: &Client) : vector<u8> {
        arg0.perform_data
    }

    public fun perform_target(arg0: &Client) : 0x1::ascii::String {
        arg0.perform_target
    }

    public fun register_client(arg0: &mut AutomationRegistry, arg1: u8, arg2: vector<u8>, arg3: vector<0x2::object::ID>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 1 || arg1 == 2, 0);
        let v0 = 0x1::ascii::string(arg2);
        let v1 = 0x1::ascii::as_bytes(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 + 1 < 0x1::vector::length<u8>(v1)) {
            if (*0x1::vector::borrow<u8>(v1, v3) == 58 && *0x1::vector::borrow<u8>(v1, v3 + 1) == 58) {
                v2 = v2 + 1;
                v3 = v3 + 1;
            };
            v3 = v3 + 1;
        };
        assert!(v2 == 2, 11);
        let v4 = Client{
            id                 : 0x2::object::new(arg5),
            mode               : arg1,
            owner              : 0x2::tx_context::sender(arg5),
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            pending_withdrawal : 0,
            withdrawal_after   : 0,
            next_deadline      : 0,
            paused             : false,
            perform_target     : v0,
            perform_args       : arg3,
            perform_data       : arg4,
        };
        let v5 = 0x2::object::id<Client>(&v4);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.clients, v5);
        let v6 = ClientRegistered{
            client_id : v5,
            owner     : 0x2::tx_context::sender(arg5),
            mode      : arg1,
        };
        0x2::event::emit<ClientRegistered>(v6);
        0x2::transfer::share_object<Client>(v4);
    }

    public fun request_withdrawal(arg0: &mut Client, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 5);
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 6);
        arg0.pending_withdrawal = arg1;
        arg0.withdrawal_after = 0x2::clock::timestamp_ms(arg2) + 3600000;
        let v0 = WithdrawalRequested{
            client_id : 0x2::object::id<Client>(arg0),
            amount    : arg1,
            after     : arg0.withdrawal_after,
        };
        0x2::event::emit<WithdrawalRequested>(v0);
    }

    public fun roll_deadline(arg0: &mut Client, arg1: &PerformTicket, arg2: u64) {
        assert!(arg1.client_id == 0x2::object::id<Client>(arg0), 9);
        arg0.next_deadline = arg2;
    }

    public fun set_automation_fee(arg0: &AutomationAdminCap, arg1: &mut AutomationRegistry, arg2: u64) {
        arg1.automation_fee = arg2;
    }

    public fun set_client_paused(arg0: &mut Client, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        arg0.paused = arg1;
    }

    public fun set_next_deadline(arg0: &mut Client, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        arg0.next_deadline = arg1;
    }

    public fun set_paused(arg0: &AutomationAdminCap, arg1: &mut AutomationRegistry, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_perform_args(arg0: &mut Client, arg1: vector<0x2::object::ID>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        arg0.perform_args = arg1;
    }

    public fun set_perform_data(arg0: &mut Client, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        arg0.perform_data = arg1;
    }

    public fun withdraw_keeper_payment(arg0: &mut AutomationRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.pending_payments, v0), 10);
        let v1 = 0x2::table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.pending_payments, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg1), v0);
        let v2 = KeeperPaid{
            keeper : v0,
            amount : 0x2::balance::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<KeeperPaid>(v2);
    }

    // decompiled from Move bytecode v7
}

