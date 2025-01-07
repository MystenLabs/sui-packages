module 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::roles {
    struct Roles<phantom T0> has store {
        data: 0x2::bag::Bag,
    }

    struct OwnerRole<phantom T0> has drop {
        dummy_field: bool,
    }

    struct OwnerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MasterMinterKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BlocklisterKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PauserKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MetadataUpdaterKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MasterMinterChanged<phantom T0> has copy, drop {
        old_master_minter: address,
        new_master_minter: address,
    }

    struct BlocklisterChanged<phantom T0> has copy, drop {
        old_blocklister: address,
        new_blocklister: address,
    }

    struct PauserChanged<phantom T0> has copy, drop {
        old_pauser: address,
        new_pauser: address,
    }

    struct MetadataUpdaterChanged<phantom T0> has copy, drop {
        old_metadata_updater: address,
        new_metadata_updater: address,
    }

    public(friend) fun new<T0>(arg0: address, arg1: address, arg2: address, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : Roles<T0> {
        let v0 = 0x2::bag::new(arg5);
        let v1 = OwnerKey{dummy_field: false};
        let v2 = OwnerRole<T0>{dummy_field: false};
        0x2::bag::add<OwnerKey, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::TwoStepRole<OwnerRole<T0>>>(&mut v0, v1, 0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::new<OwnerRole<T0>>(v2, arg0));
        let v3 = MasterMinterKey{dummy_field: false};
        0x2::bag::add<MasterMinterKey, address>(&mut v0, v3, arg1);
        let v4 = BlocklisterKey{dummy_field: false};
        0x2::bag::add<BlocklisterKey, address>(&mut v0, v4, arg2);
        let v5 = PauserKey{dummy_field: false};
        0x2::bag::add<PauserKey, address>(&mut v0, v5, arg3);
        let v6 = MetadataUpdaterKey{dummy_field: false};
        0x2::bag::add<MetadataUpdaterKey, address>(&mut v0, v6, arg4);
        Roles<T0>{data: v0}
    }

    public fun blocklister<T0>(arg0: &Roles<T0>) : address {
        let v0 = BlocklisterKey{dummy_field: false};
        *0x2::bag::borrow<BlocklisterKey, address>(&arg0.data, v0)
    }

    public fun master_minter<T0>(arg0: &Roles<T0>) : address {
        let v0 = MasterMinterKey{dummy_field: false};
        *0x2::bag::borrow<MasterMinterKey, address>(&arg0.data, v0)
    }

    public fun metadata_updater<T0>(arg0: &Roles<T0>) : address {
        let v0 = MetadataUpdaterKey{dummy_field: false};
        *0x2::bag::borrow<MetadataUpdaterKey, address>(&arg0.data, v0)
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

    fun update_address<T0, T1: copy + drop + store>(arg0: &mut Roles<T0>, arg1: T1, arg2: address) : address {
        0x2::bag::add<T1, address>(&mut arg0.data, arg1, arg2);
        0x2::bag::remove<T1, address>(&mut arg0.data, arg1)
    }

    public(friend) fun update_blocklister<T0>(arg0: &mut Roles<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<OwnerRole<T0>>(owner_role<T0>(arg0), arg2);
        let v0 = BlocklisterKey{dummy_field: false};
        let v1 = BlocklisterChanged<T0>{
            old_blocklister : update_address<T0, BlocklisterKey>(arg0, v0, arg1),
            new_blocklister : arg1,
        };
        0x2::event::emit<BlocklisterChanged<T0>>(v1);
    }

    public(friend) fun update_master_minter<T0>(arg0: &mut Roles<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<OwnerRole<T0>>(owner_role<T0>(arg0), arg2);
        let v0 = MasterMinterKey{dummy_field: false};
        let v1 = MasterMinterChanged<T0>{
            old_master_minter : update_address<T0, MasterMinterKey>(arg0, v0, arg1),
            new_master_minter : arg1,
        };
        0x2::event::emit<MasterMinterChanged<T0>>(v1);
    }

    public(friend) fun update_metadata_updater<T0>(arg0: &mut Roles<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<OwnerRole<T0>>(owner_role<T0>(arg0), arg2);
        let v0 = MetadataUpdaterKey{dummy_field: false};
        let v1 = MetadataUpdaterChanged<T0>{
            old_metadata_updater : update_address<T0, MetadataUpdaterKey>(arg0, v0, arg1),
            new_metadata_updater : arg1,
        };
        0x2::event::emit<MetadataUpdaterChanged<T0>>(v1);
    }

    public(friend) fun update_pauser<T0>(arg0: &mut Roles<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<OwnerRole<T0>>(owner_role<T0>(arg0), arg2);
        let v0 = PauserKey{dummy_field: false};
        let v1 = PauserChanged<T0>{
            old_pauser : update_address<T0, PauserKey>(arg0, v0, arg1),
            new_pauser : arg1,
        };
        0x2::event::emit<PauserChanged<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

