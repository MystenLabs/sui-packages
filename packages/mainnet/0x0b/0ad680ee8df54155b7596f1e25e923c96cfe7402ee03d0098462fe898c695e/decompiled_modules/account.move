module 0xdaebb123115985f817053cae3eb18b5da08b6dee8978236de2ee9d3face7059::account {
    struct Account has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct AccountRoot has key {
        id: 0x2::object::UID,
    }

    struct AccountAdminCap has key {
        id: 0x2::object::UID,
    }

    struct AccountKey has copy, drop, store {
        pos0: address,
        pos1: u64,
    }

    struct AccountKeyV2 has copy, drop, store {
        pos0: vector<u8>,
    }

    struct AccountAdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AccountAdminCapCreated has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
        admin: address,
    }

    struct AccountAdminCapTransferred has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
        admin: address,
    }

    struct AccountAdminCapDestroyed has copy, drop {
        cap_id: 0x2::object::ID,
        admin: address,
    }

    struct RegisteredAccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        account_key: vector<u8>,
        owner: address,
        creator: address,
    }

    struct AccountOwnerChanged has copy, drop {
        account_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
        actor: address,
    }

    public fun assert_owner(arg0: &Account, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
    }

    fun assert_valid_account_key(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 4);
    }

    fun assert_valid_owner(arg0: address) {
        assert!(arg0 != @0x0, 5);
    }

    public fun bootstrap_admin_cap(arg0: &mut AccountRoot, arg1: &0x2::package::UpgradeCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_valid_owner(arg2);
        assert!(0x2::package::upgrade_package(arg1) == 0x2::object::id_from_address(0x1::type_name::defining_id<AccountAdminCap>()), 3);
        let v0 = AccountAdminCapKey{dummy_field: false};
        let v1 = 0x2::derived_object::claim<AccountAdminCapKey>(&mut arg0.id, v0);
        let v2 = AccountAdminCapCreated{
            cap_id    : 0x2::object::uid_to_inner(&v1),
            recipient : arg2,
            admin     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AccountAdminCapCreated>(v2);
        let v3 = AccountAdminCap{id: v1};
        0x2::transfer::transfer<AccountAdminCap>(v3, arg2);
    }

    public fun create(arg0: &mut AccountRoot, arg1: u64, arg2: &0x2::tx_context::TxContext) : Account {
        abort 6
    }

    public fun create_for(arg0: &mut AccountRoot, arg1: address, arg2: u64) : Account {
        abort 6
    }

    public fun create_for_account_key(arg0: &mut AccountRoot, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : Account {
        assert_valid_account_key(&arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = AccountKeyV2{pos0: arg1};
        let v2 = 0x2::derived_object::claim<AccountKeyV2>(&mut arg0.id, v1);
        let v3 = RegisteredAccountCreated{
            account_id  : 0x2::object::uid_to_inner(&v2),
            account_key : arg1,
            owner       : v0,
            creator     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RegisteredAccountCreated>(v3);
        Account{
            id    : v2,
            owner : v0,
        }
    }

    public fun derive_account_address(arg0: &AccountRoot, arg1: address, arg2: u64) : address {
        let v0 = AccountKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        0x2::derived_object::derive_address<vector<u8>>(0x2::object::uid_to_inner(&arg0.id), 0x1::bcs::to_bytes<AccountKey>(&v0))
    }

    public fun derive_account_id(arg0: &AccountRoot, arg1: address, arg2: u64) : 0x2::object::ID {
        0x2::object::id_from_address(derive_account_address(arg0, arg1, arg2))
    }

    public fun derive_account_key_address(arg0: &AccountRoot, arg1: vector<u8>) : address {
        assert_valid_account_key(&arg1);
        let v0 = AccountKeyV2{pos0: arg1};
        0x2::derived_object::derive_address<AccountKeyV2>(0x2::object::uid_to_inner(&arg0.id), v0)
    }

    public fun derive_account_key_id(arg0: &AccountRoot, arg1: vector<u8>) : 0x2::object::ID {
        0x2::object::id_from_address(derive_account_key_address(arg0, arg1))
    }

    public fun destroy_admin_cap(arg0: AccountAdminCap, arg1: &0x2::tx_context::TxContext) {
        let AccountAdminCap { id: v0 } = arg0;
        let v1 = AccountAdminCapDestroyed{
            cap_id : 0x2::object::uid_to_inner(&v0),
            admin  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AccountAdminCapDestroyed>(v1);
        0x2::object::delete(v0);
    }

    public(friend) fun extend(arg0: &mut Account) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun get_address(arg0: &Account) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun id(arg0: &Account) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountRoot{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AccountRoot>(v0);
    }

    public fun multi_receive<T0: store + key>(arg0: &mut Account, arg1: vector<0x2::transfer::Receiving<T0>>, arg2: &0x2::tx_context::TxContext) : vector<T0> {
        assert_owner(arg0, arg2);
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::reverse<0x2::transfer::Receiving<T0>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<T0>>(&arg1)) {
            0x1::vector::push_back<T0>(&mut v0, 0x2::transfer::public_receive<T0>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<T0>>(&mut arg1)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<T0>>(arg1);
        v0
    }

    public fun multi_receive_coins<T0>(arg0: &mut Account, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner(arg0, arg2);
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x1::vector::reverse<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1)) {
            let v2 = v0;
            0x2::coin::join<T0>(&mut v2, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1)));
            v0 = v2;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1);
        v0
    }

    public fun owner(arg0: &Account) : address {
        arg0.owner
    }

    public fun receive<T0: store + key>(arg0: &mut Account, arg1: 0x2::transfer::Receiving<T0>, arg2: &0x2::tx_context::TxContext) : T0 {
        assert_owner(arg0, arg2);
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun rotate_owner(arg0: &AccountAdminCap, arg1: &mut Account, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_valid_owner(arg2);
        arg1.owner = arg2;
        let v0 = AccountOwnerChanged{
            account_id : id(arg1),
            old_owner  : arg1.owner,
            new_owner  : arg2,
            actor      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AccountOwnerChanged>(v0);
    }

    public fun share(arg0: Account) {
        0x2::transfer::share_object<Account>(arg0);
    }

    public fun transfer_admin_cap(arg0: AccountAdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_valid_owner(arg1);
        let v0 = AccountAdminCapTransferred{
            cap_id    : 0x2::object::uid_to_inner(&arg0.id),
            recipient : arg1,
            admin     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AccountAdminCapTransferred>(v0);
        0x2::transfer::transfer<AccountAdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

