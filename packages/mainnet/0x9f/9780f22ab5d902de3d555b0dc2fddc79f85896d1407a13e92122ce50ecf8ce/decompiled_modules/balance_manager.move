module 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::balance_manager {
    struct BalanceManager has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        tx_allow_listed: 0x2::vec_set::VecSet<0x2::object::ID>,
        cap_id: 0x2::object::ID,
    }

    struct BalanceManagerCap has store, key {
        id: 0x2::object::UID,
        balance_manager_id: 0x2::object::ID,
    }

    struct PlayCap has store, key {
        id: 0x2::object::UID,
        balance_manager_id: 0x2::object::ID,
    }

    struct PlayProof has drop {
        balance_manager_id: 0x2::object::ID,
        player: address,
    }

    struct BalanceManagerCreatedEvent has copy, drop {
        balance_manager_id: 0x2::object::ID,
        balance_manager_cap_id: 0x2::object::ID,
    }

    struct DepositCompletedEvent has copy, drop {
        balance_manager_id: 0x2::object::ID,
        amount: u64,
    }

    struct WithdrawalProcessedEvent has copy, drop {
        balance_manager_id: 0x2::object::ID,
        amount: u64,
    }

    struct PlayCapMintedEvent has copy, drop {
        balance_manager_id: 0x2::object::ID,
        play_cap_id: 0x2::object::ID,
    }

    struct PlayCapRevokedEvent has copy, drop {
        balance_manager_id: 0x2::object::ID,
        play_cap_id: 0x2::object::ID,
    }

    public fun balance(arg0: &BalanceManager) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun id(arg0: &BalanceManager) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (BalanceManager, BalanceManagerCap) {
        let v0 = 0x2::object::new(arg0);
        let v1 = BalanceManager{
            id              : 0x2::object::new(arg0),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            tx_allow_listed : 0x2::vec_set::empty<0x2::object::ID>(),
            cap_id          : 0x2::object::uid_to_inner(&v0),
        };
        let v2 = BalanceManagerCap{
            id                 : v0,
            balance_manager_id : id(&v1),
        };
        let v3 = BalanceManagerCreatedEvent{
            balance_manager_id     : id(&v1),
            balance_manager_cap_id : 0x2::object::uid_to_inner(&v2.id),
        };
        0x2::event::emit<BalanceManagerCreatedEvent>(v3);
        (v1, v2)
    }

    public fun cap_balance_manager_id(arg0: &PlayCap) : 0x2::object::ID {
        arg0.balance_manager_id
    }

    public fun cap_id(arg0: &PlayCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun deposit(arg0: &mut BalanceManager, arg1: &BalanceManagerCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = generate_proof_as_owner(arg0, arg1, arg3);
        let v1 = DepositCompletedEvent{
            balance_manager_id : id(arg0),
            amount             : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<DepositCompletedEvent>(v1);
        deposit_with_proof(arg0, &v0, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public(friend) fun deposit_with_proof(arg0: &mut BalanceManager, arg1: &PlayProof, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        validate_proof(arg0, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg2);
    }

    public(friend) fun ensure_sufficient_funds(arg0: &BalanceManager, arg1: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 1);
    }

    public fun generate_proof_as_owner(arg0: &mut BalanceManager, arg1: &BalanceManagerCap, arg2: &0x2::tx_context::TxContext) : PlayProof {
        validate_owner(arg0, arg1);
        PlayProof{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            player             : 0x2::tx_context::sender(arg2),
        }
    }

    public fun generate_proof_as_player(arg0: &mut BalanceManager, arg1: &PlayCap, arg2: &0x2::tx_context::TxContext) : PlayProof {
        validate_player(arg0, arg1);
        PlayProof{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            player             : 0x2::tx_context::sender(arg2),
        }
    }

    public fun mint_play_cap(arg0: &mut BalanceManager, arg1: &BalanceManagerCap, arg2: &mut 0x2::tx_context::TxContext) : PlayCap {
        validate_owner(arg0, arg1);
        assert!(0x2::vec_set::size<0x2::object::ID>(&arg0.tx_allow_listed) < 1000, 4);
        let v0 = 0x2::object::new(arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.tx_allow_listed, 0x2::object::uid_to_inner(&v0));
        let v1 = PlayCapMintedEvent{
            balance_manager_id : id(arg0),
            play_cap_id        : 0x2::object::uid_to_inner(&v0),
        };
        0x2::event::emit<PlayCapMintedEvent>(v1);
        PlayCap{
            id                 : v0,
            balance_manager_id : id(arg0),
        }
    }

    public fun player(arg0: &PlayProof) : address {
        arg0.player
    }

    public fun proof_balance_manager_id(arg0: &PlayProof) : 0x2::object::ID {
        arg0.balance_manager_id
    }

    public fun revoke_play_cap(arg0: &mut BalanceManager, arg1: &BalanceManagerCap, arg2: &0x2::object::ID) {
        validate_owner(arg0, arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.tx_allow_listed, arg2), 5);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.tx_allow_listed, arg2);
        let v0 = PlayCapRevokedEvent{
            balance_manager_id : id(arg0),
            play_cap_id        : *arg2,
        };
        0x2::event::emit<PlayCapRevokedEvent>(v0);
    }

    public fun share(arg0: BalanceManager) {
        0x2::transfer::share_object<BalanceManager>(arg0);
    }

    fun validate_owner(arg0: &BalanceManager, arg1: &BalanceManagerCap) {
        assert!(arg1.balance_manager_id == id(arg0), 2);
        let v0 = arg0.cap_id;
        assert!(0x2::object::uid_as_inner(&arg1.id) == &v0, 2);
    }

    fun validate_player(arg0: &BalanceManager, arg1: &PlayCap) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.tx_allow_listed, 0x2::object::borrow_id<PlayCap>(arg1)), 3);
    }

    public fun validate_proof(arg0: &BalanceManager, arg1: &PlayProof) {
        assert!(0x2::object::id<BalanceManager>(arg0) == arg1.balance_manager_id, 6);
    }

    public fun withdraw(arg0: &mut BalanceManager, arg1: &BalanceManagerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = generate_proof_as_owner(arg0, arg1, arg3);
        let v1 = WithdrawalProcessedEvent{
            balance_manager_id : id(arg0),
            amount             : arg2,
        };
        0x2::event::emit<WithdrawalProcessedEvent>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(withdraw_with_proof(arg0, &v0, arg2), arg3)
    }

    public(friend) fun withdraw_with_proof(arg0: &mut BalanceManager, arg1: &PlayProof, arg2: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        validate_proof(arg0, arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 1);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2)
    }

    // decompiled from Move bytecode v6
}

