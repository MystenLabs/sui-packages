module 0xe3175942023a00d4510ff1f3a73f2c269a1623b8b2cea1abbe0b8c182743e1b7::xbtc {
    struct XBTC has drop {
        dummy_field: bool,
    }

    struct XBTCReceiver has store, key {
        id: 0x2::object::UID,
        receiver: address,
    }

    struct MintEvent has copy, drop {
        minter: address,
        receiver: address,
        amount: u64,
    }

    struct BurnEvent has copy, drop {
        account: address,
        amount: u64,
    }

    struct AddDenyListEvent has copy, drop {
        denylister: address,
        account: address,
    }

    struct RemoveDenyListEvent has copy, drop {
        denylister: address,
        account: address,
    }

    struct BatchAddDenyListEvent has copy, drop {
        denylister: address,
        accounts: vector<address>,
    }

    struct BatchRemoveDenyListEvent has copy, drop {
        denylister: address,
        accounts: vector<address>,
    }

    struct PauseEvent has copy, drop {
        pauser: address,
        paused: bool,
    }

    struct SetReceiverEvent has copy, drop {
        denylister: address,
        old_receiver: address,
        new_receiver: address,
    }

    struct TransferMinterRoleEvent has copy, drop {
        old_minter: address,
        new_minter: address,
    }

    struct TransferDenylisterRoleEvent has copy, drop {
        old_denylister: address,
        new_denylister: address,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XBTC>, arg1: 0x2::coin::Coin<XBTC>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<XBTC>(arg0, arg1);
        let v0 = BurnEvent{
            account : 0x2::tx_context::sender(arg2),
            amount  : 0x2::coin::value<XBTC>(&arg1),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun add_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<XBTC>(arg0, arg1, arg2, arg3);
        let v0 = AddDenyListEvent{
            denylister : 0x2::tx_context::sender(arg3),
            account    : arg2,
        };
        0x2::event::emit<AddDenyListEvent>(v0);
    }

    public entry fun batch_add_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 4);
        let v1 = 0;
        while (v1 < v0) {
            0x2::coin::deny_list_v2_add<XBTC>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v1), arg3);
            v1 = v1 + 1;
        };
        let v2 = BatchAddDenyListEvent{
            denylister : 0x2::tx_context::sender(arg3),
            accounts   : arg2,
        };
        0x2::event::emit<BatchAddDenyListEvent>(v2);
    }

    public entry fun batch_remove_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 4);
        let v1 = 0;
        while (v1 < v0) {
            0x2::coin::deny_list_v2_remove<XBTC>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v1), arg3);
            v1 = v1 + 1;
        };
        let v2 = BatchRemoveDenyListEvent{
            denylister : 0x2::tx_context::sender(arg3),
            accounts   : arg2,
        };
        0x2::event::emit<BatchRemoveDenyListEvent>(v2);
    }

    fun init(arg0: XBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<XBTC>(arg0, 8, b"xBTC", b"Regulated Bitcoin", b"A regulated Bitcoin representation on Sui with compliance features", 0x1::option::none<0x2::url::Url>(), true, arg1);
        let v3 = XBTCReceiver{
            id       : 0x2::object::new(arg1),
            receiver : @0x0,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBTC>>(v0, @0x4ac95fc4186c2c33ada72045c1221efa1cbe26c33830800989d01a613de0fe16);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XBTC>>(v1, @0x4ac95fc4186c2c33ada72045c1221efa1cbe26c33830800989d01a613de0fe16);
        0x2::transfer::share_object<XBTCReceiver>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XBTC>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XBTC>, arg1: &XBTCReceiver, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(arg3 != @0x0, 3);
        assert!(arg3 == arg1.receiver, 2);
        0x2::coin::mint_and_transfer<XBTC>(arg0, arg2, arg3, arg4);
        let v0 = MintEvent{
            minter   : 0x2::tx_context::sender(arg4),
            receiver : arg3,
            amount   : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun remove_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<XBTC>(arg0, arg1, arg2, arg3);
        let v0 = RemoveDenyListEvent{
            denylister : 0x2::tx_context::sender(arg3),
            account    : arg2,
        };
        0x2::event::emit<RemoveDenyListEvent>(v0);
    }

    public entry fun set_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            0x2::coin::deny_list_v2_enable_global_pause<XBTC>(arg0, arg1, arg3);
        } else {
            0x2::coin::deny_list_v2_disable_global_pause<XBTC>(arg0, arg1, arg3);
        };
        let v0 = PauseEvent{
            pauser : 0x2::tx_context::sender(arg3),
            paused : arg2,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public entry fun set_receiver(arg0: &mut 0x2::coin::DenyCapV2<XBTC>, arg1: &mut XBTCReceiver, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 3);
        arg1.receiver = arg2;
        let v0 = SetReceiverEvent{
            denylister   : 0x2::tx_context::sender(arg3),
            old_receiver : arg1.receiver,
            new_receiver : arg2,
        };
        0x2::event::emit<SetReceiverEvent>(v0);
    }

    public entry fun transfer_denylister_role(arg0: 0x2::coin::DenyCapV2<XBTC>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XBTC>>(arg0, arg1);
        let v0 = TransferDenylisterRoleEvent{
            old_denylister : 0x2::tx_context::sender(arg2),
            new_denylister : arg1,
        };
        0x2::event::emit<TransferDenylisterRoleEvent>(v0);
    }

    public entry fun transfer_minter_role(arg0: 0x2::coin::TreasuryCap<XBTC>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBTC>>(arg0, arg1);
        let v0 = TransferMinterRoleEvent{
            old_minter : 0x2::tx_context::sender(arg2),
            new_minter : arg1,
        };
        0x2::event::emit<TransferMinterRoleEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

