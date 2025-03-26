module 0xd9ea7b4e58c0df878c4b90e785f937d73e3c77fa9a8105f72a6fca3b86994f3a::xbtc {
    struct XBTC has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Receiver has store, key {
        id: 0x2::object::UID,
        address: address,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        burner: address,
    }

    struct DenyListAddedEvent has copy, drop {
        address: address,
    }

    struct DenyListRemovedEvent has copy, drop {
        address: address,
    }

    struct BatchDenyListAddedEvent has copy, drop {
        addresses: vector<address>,
        count: u64,
    }

    struct BatchDenyListRemovedEvent has copy, drop {
        addresses: vector<address>,
        count: u64,
    }

    struct PauseEnabledEvent has copy, drop {
        dummy_field: bool,
    }

    struct PauseDisabledEvent has copy, drop {
        dummy_field: bool,
    }

    struct ReceiverSetEvent has copy, drop {
        address: address,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XBTC>, arg1: 0x2::coin::Coin<XBTC>, arg2: &0x2::tx_context::TxContext) {
        let v0 = BurnEvent{
            amount : 0x2::coin::value<XBTC>(&arg1),
            burner : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BurnEvent>(v0);
        0x2::coin::burn<XBTC>(arg0, arg1);
    }

    public entry fun add_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DenyListAddedEvent{address: arg2};
        0x2::event::emit<DenyListAddedEvent>(v0);
        0x2::coin::deny_list_v2_add<XBTC>(arg0, arg1, arg2, arg3);
    }

    public entry fun batch_add_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = BatchDenyListAddedEvent{
            addresses : arg2,
            count     : v0,
        };
        0x2::event::emit<BatchDenyListAddedEvent>(v1);
        let v2 = 0;
        while (v2 < v0) {
            0x2::coin::deny_list_v2_add<XBTC>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v2), arg3);
            v2 = v2 + 1;
        };
    }

    public entry fun batch_remove_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = BatchDenyListRemovedEvent{
            addresses : arg2,
            count     : v0,
        };
        0x2::event::emit<BatchDenyListRemovedEvent>(v1);
        let v2 = 0;
        while (v2 < v0) {
            0x2::coin::deny_list_v2_remove<XBTC>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v2), arg3);
            v2 = v2 + 1;
        };
    }

    public entry fun disable_global_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PauseDisabledEvent{dummy_field: false};
        0x2::event::emit<PauseDisabledEvent>(v0);
        0x2::coin::deny_list_v2_disable_global_pause<XBTC>(arg0, arg1, arg2);
    }

    public entry fun enable_global_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PauseEnabledEvent{dummy_field: false};
        0x2::event::emit<PauseEnabledEvent>(v0);
        0x2::coin::deny_list_v2_enable_global_pause<XBTC>(arg0, arg1, arg2);
    }

    fun init(arg0: XBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<XBTC>(arg0, 8, b"xBTC", b"Regulated Bitcoin", b"A regulated Bitcoin representation on Sui with compliance features", 0x1::option::none<0x2::url::Url>(), true, arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = Receiver{
            id      : 0x2::object::new(arg1),
            address : v4,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBTC>>(v0, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XBTC>>(v1, v4);
        0x2::transfer::public_transfer<AdminCap>(v3, v4);
        0x2::transfer::public_transfer<Receiver>(v5, v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XBTC>>(v2);
    }

    public fun is_denied_current_epoch(arg0: &0x2::deny_list::DenyList, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::coin::deny_list_v2_contains_current_epoch<XBTC>(arg0, arg1, arg2)
    }

    public fun is_denied_next_epoch(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<XBTC>(arg0, arg1)
    }

    public fun is_global_pause_enabled_current_epoch(arg0: &0x2::deny_list::DenyList, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_current_epoch<XBTC>(arg0, arg1)
    }

    public fun is_global_pause_enabled_next_epoch(arg0: &0x2::deny_list::DenyList) : bool {
        0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<XBTC>(arg0)
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XBTC>, arg1: &Receiver, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(arg3 == arg1.address, 2);
        let v0 = MintEvent{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<MintEvent>(v0);
        0x2::coin::mint_and_transfer<XBTC>(arg0, arg2, arg3, arg4);
    }

    public entry fun remove_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XBTC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DenyListRemovedEvent{address: arg2};
        0x2::event::emit<DenyListRemovedEvent>(v0);
        0x2::coin::deny_list_v2_remove<XBTC>(arg0, arg1, arg2, arg3);
    }

    public entry fun set_receiver(arg0: &0x2::coin::TreasuryCap<XBTC>, arg1: &mut Receiver, arg2: address) {
        let v0 = ReceiverSetEvent{address: arg2};
        0x2::event::emit<ReceiverSetEvent>(v0);
        arg1.address = arg2;
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

