module 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles {
    struct Roles<phantom T0> has store {
        data: 0x2::bag::Bag,
    }

    struct OwnerRole<phantom T0> has drop {
        dummy_field: bool,
    }

    struct OwnerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PauserKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OwnerChanged<phantom T0> has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct PauserChanged<phantom T0> has copy, drop {
        old_pauser: address,
        new_pauser: address,
    }

    public(friend) fun new<T0>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Roles<T0> {
        let v0 = 0x2::bag::new(arg2);
        let v1 = OwnerRole<T0>{dummy_field: false};
        let v2 = OwnerKey{dummy_field: false};
        0x2::bag::add<OwnerKey, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>>>(&mut v0, v2, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::new<OwnerRole<T0>>(v1, arg0));
        let v3 = PauserKey{dummy_field: false};
        0x2::bag::add<PauserKey, address>(&mut v0, v3, arg1);
        Roles<T0>{data: v0}
    }

    public(friend) fun accept_ownership<T0>(arg0: &mut Roles<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = owner_role_mut<T0>(arg0);
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::accept_role<OwnerRole<T0>>(v0, arg1);
        let v1 = OwnerChanged<T0>{
            old_owner : 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::active_address<OwnerRole<T0>>(v0),
            new_owner : 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::active_address<OwnerRole<T0>>(v0),
        };
        0x2::event::emit<OwnerChanged<T0>>(v1);
    }

    public fun is_owner<T0>(arg0: &Roles<T0>, arg1: address) : bool {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::active_address<OwnerRole<T0>>(owner_role<T0>(arg0)) == arg1
    }

    public fun is_pauser<T0>(arg0: &Roles<T0>, arg1: address) : bool {
        pauser<T0>(arg0) == arg1 || owner<T0>(arg0) == arg1
    }

    public fun master_owner<T0>(arg0: &Roles<T0>) : address {
        owner<T0>(arg0)
    }

    public fun migrate_owner_to_two_step<T0>(arg0: &mut Roles<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = OwnerKey{dummy_field: false};
        let v1 = 0x2::bag::remove<OwnerKey, address>(&mut arg0.data, v0);
        assert!(0x2::tx_context::sender(arg1) == v1, 1);
        let v2 = OwnerRole<T0>{dummy_field: false};
        let v3 = OwnerKey{dummy_field: false};
        0x2::bag::add<OwnerKey, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>>>(&mut arg0.data, v3, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::new<OwnerRole<T0>>(v2, v1));
    }

    public fun owner<T0>(arg0: &Roles<T0>) : address {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::active_address<OwnerRole<T0>>(owner_role<T0>(arg0))
    }

    public(friend) fun owner_role<T0>(arg0: &Roles<T0>) : &0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>> {
        let v0 = OwnerKey{dummy_field: false};
        0x2::bag::borrow<OwnerKey, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>>>(&arg0.data, v0)
    }

    public(friend) fun owner_role_mut<T0>(arg0: &mut Roles<T0>) : &mut 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>> {
        let v0 = OwnerKey{dummy_field: false};
        0x2::bag::borrow_mut<OwnerKey, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>>>(&mut arg0.data, v0)
    }

    public fun pauser<T0>(arg0: &Roles<T0>) : address {
        let v0 = PauserKey{dummy_field: false};
        *0x2::bag::borrow<PauserKey, address>(&arg0.data, v0)
    }

    public fun pending_owner<T0>(arg0: &Roles<T0>) : 0x1::option::Option<address> {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::pending_address<OwnerRole<T0>>(owner_role<T0>(arg0))
    }

    public(friend) fun transfer_ownership<T0>(arg0: &mut Roles<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::begin_role_transfer<OwnerRole<T0>>(owner_role_mut<T0>(arg0), arg1, arg2);
    }

    fun update_address<T0, T1: copy + drop + store>(arg0: &mut Roles<T0>, arg1: T1, arg2: address) : address {
        0x2::bag::add<T1, address>(&mut arg0.data, arg1, arg2);
        0x2::bag::remove<T1, address>(&mut arg0.data, arg1)
    }

    public(friend) fun update_owner<T0>(arg0: &mut Roles<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner<T0>(arg0, 0x2::tx_context::sender(arg2)), 1);
        let v0 = OwnerKey{dummy_field: false};
        let v1 = 0x2::bag::remove<OwnerKey, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>>>(&mut arg0.data, v0);
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::destroy<OwnerRole<T0>>(v1);
        let v2 = OwnerRole<T0>{dummy_field: false};
        let v3 = OwnerKey{dummy_field: false};
        0x2::bag::add<OwnerKey, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>>>(&mut arg0.data, v3, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::new<OwnerRole<T0>>(v2, arg1));
        let v4 = OwnerChanged<T0>{
            old_owner : 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::active_address<OwnerRole<T0>>(&v1),
            new_owner : arg1,
        };
        0x2::event::emit<OwnerChanged<T0>>(v4);
    }

    public(friend) fun update_pauser<T0>(arg0: &mut Roles<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner<T0>(arg0, 0x2::tx_context::sender(arg2)), 1);
        let v0 = PauserKey{dummy_field: false};
        let v1 = PauserChanged<T0>{
            old_pauser : update_address<T0, PauserKey>(arg0, v0, arg1),
            new_pauser : arg1,
        };
        0x2::event::emit<PauserChanged<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

