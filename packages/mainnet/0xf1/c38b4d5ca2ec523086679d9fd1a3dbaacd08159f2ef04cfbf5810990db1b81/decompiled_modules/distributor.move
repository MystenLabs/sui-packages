module 0xf1c38b4d5ca2ec523086679d9fd1a3dbaacd08159f2ef04cfbf5810990db1b81::distributor {
    struct Distributor has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        guardian: address,
        claims_paused: bool,
        vault: 0x2::bag::Bag,
        executed_ids: 0x2::table::Table<u64, bool>,
    }

    struct DepositEvent has copy, drop {
        amount: u64,
        depositor: address,
    }

    struct ClaimEvent has copy, drop {
        ids: vector<u64>,
        amount: u64,
        receiver: address,
    }

    struct GuardianUpdatedEvent has copy, drop {
        old_guardian: address,
        new_guardian: address,
    }

    struct AdminUpdatedEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct ClaimsPausedEvent has copy, drop {
        paused: bool,
    }

    fun new(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Distributor {
        assert!(arg0 != @0x0, 1001);
        assert!(arg1 != @0x0, 1001);
        Distributor{
            id            : 0x2::object::new(arg2),
            version       : 1,
            admin         : arg0,
            guardian      : arg1,
            claims_paused : false,
            vault         : 0x2::bag::new(arg2),
            executed_ids  : 0x2::table::new<u64, bool>(arg2),
        }
    }

    public fun balance<T0>(arg0: &Distributor) : u64 {
        assert_version(arg0);
        let v0 = vault_key<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.vault, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.vault, v0))
        } else {
            0
        }
    }

    public fun admin(arg0: &Distributor) : address {
        assert_version(arg0);
        arg0.admin
    }

    fun assert_active(arg0: &Distributor) {
        assert!(!arg0.claims_paused, 1003);
    }

    fun assert_admin(arg0: &Distributor, arg1: address) {
        assert!(arg0.admin == arg1, 1000);
    }

    fun assert_and_record_ids(arg0: &mut Distributor, arg1: &vector<u64>) {
        let v0 = 0x2::vec_set::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            let v2 = *0x1::vector::borrow<u64>(arg1, v1);
            assert!(!0x2::vec_set::contains<u64>(&v0, &v2), 1007);
            assert!(!0x2::table::contains<u64, bool>(&arg0.executed_ids, v2), 1004);
            0x2::vec_set::insert<u64>(&mut v0, v2);
            0x2::table::add<u64, bool>(&mut arg0.executed_ids, v2, true);
            v1 = v1 + 1;
        };
    }

    fun assert_receiver(arg0: address, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg1), 1005);
    }

    fun assert_valid_request(arg0: &vector<u64>, arg1: u64) {
        assert!(arg1 > 0, 1008);
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 > 0, 1006);
        assert!(v0 <= 200, 1009);
    }

    fun assert_version(arg0: &Distributor) {
        assert!(arg0.version == 1, 1011);
    }

    public fun claim<T0>(arg0: &mut Distributor, arg1: vector<u64>, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_active(arg0);
        assert_receiver(arg3, arg5);
        assert_valid_request(&arg1, arg2);
        assert!(0xf1c38b4d5ca2ec523086679d9fd1a3dbaacd08159f2ef04cfbf5810990db1b81::signature::verify_claim_signature(&arg1, arg2, arg3, arg4) == arg0.guardian, 1002);
        execute_claim<T0>(arg0, arg1, arg2, arg3, arg5);
    }

    public fun claim_message_bytes(arg0: &vector<u64>, arg1: u64, arg2: address) : vector<u8> {
        0xf1c38b4d5ca2ec523086679d9fd1a3dbaacd08159f2ef04cfbf5810990db1b81::signature::build_claim_message(arg0, arg1, arg2)
    }

    public fun claims_paused(arg0: &Distributor) : bool {
        assert_version(arg0);
        arg0.claims_paused
    }

    public fun deposit<T0>(arg0: &mut Distributor, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = vault_key<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.vault, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        let v1 = DepositEvent{
            amount    : 0x2::coin::value<T0>(&arg1),
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun execute_claim<T0>(arg0: &mut Distributor, arg1: vector<u64>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_and_record_ids(arg0, &arg1);
        assert!(balance<T0>(arg0) >= arg2, 1010);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, vault_key<T0>()), arg2, arg4), arg3);
        let v0 = ClaimEvent{
            ids      : arg1,
            amount   : arg2,
            receiver : arg3,
        };
        0x2::event::emit<ClaimEvent>(v0);
    }

    public fun guardian(arg0: &Distributor) : address {
        assert_version(arg0);
        arg0.guardian
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        0x2::transfer::share_object<Distributor>(new(v0, v0, arg0));
    }

    public fun is_claim_id_executed(arg0: &Distributor, arg1: u64) : bool {
        assert_version(arg0);
        0x2::table::contains<u64, bool>(&arg0.executed_ids, arg1)
    }

    public fun set_claims_paused(arg0: &mut Distributor, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.claims_paused = arg1;
        let v0 = ClaimsPausedEvent{paused: arg1};
        0x2::event::emit<ClaimsPausedEvent>(v0);
    }

    public fun update_admin(arg0: &mut Distributor, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 != @0x0, 1001);
        arg0.admin = arg1;
        let v0 = AdminUpdatedEvent{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminUpdatedEvent>(v0);
    }

    public fun update_guardian(arg0: &mut Distributor, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 != @0x0, 1001);
        arg0.guardian = arg1;
        let v0 = GuardianUpdatedEvent{
            old_guardian : arg0.guardian,
            new_guardian : arg1,
        };
        0x2::event::emit<GuardianUpdatedEvent>(v0);
    }

    public fun upgrade(arg0: &mut Distributor, arg1: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg1));
        let v0 = arg0.version + 1;
        assert!(v0 == 1, 1011);
        arg0.version = v0;
    }

    fun vault_key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    public fun version(arg0: &Distributor) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

