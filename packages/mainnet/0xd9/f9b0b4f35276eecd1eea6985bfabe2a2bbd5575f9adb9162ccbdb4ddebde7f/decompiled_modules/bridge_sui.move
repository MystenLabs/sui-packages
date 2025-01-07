module 0xd9f9b0b4f35276eecd1eea6985bfabe2a2bbd5575f9adb9162ccbdb4ddebde7f::bridge_sui {
    struct LockAssetTokenEvent has copy, drop, store {
        uid: u64,
        amount: u64,
        locked_time: u64,
        coin_type: 0x1::string::String,
        to_network_type: u64,
        sender: address,
        to_address: 0x1::string::String,
    }

    struct BurnToBridgeTokenEvent has copy, drop, store {
        uid: u64,
        amount: u64,
        start_at: u64,
        coin_type: 0x1::string::String,
        to_network_type: u64,
        sender: address,
        to_address: 0x1::string::String,
    }

    struct MintToTransferTokenEvent has copy, drop, store {
        amount: u64,
        transfered_time: u64,
        coin_type: 0x1::string::String,
        to_address: address,
    }

    struct TransferAssetTokenEvent has copy, drop, store {
        amount: u64,
        transfered_time: u64,
        coin_type: 0x1::string::String,
        to_address: address,
    }

    struct WithdrawEvent has copy, drop, store {
        amount: u64,
        coin_type: 0x1::string::String,
        withdraw_time: u64,
        to: address,
    }

    struct BridgeData has store, key {
        id: 0x2::object::UID,
        admin_1: address,
        admin_2: address,
        total_coin_type: u64,
        to_network: 0x2::table::Table<u64, 0x1::string::String>,
        allowed_coins: 0x2::table::Table<0x1::string::String, u64>,
        current_id: u64,
    }

    struct BridgeItem<phantom T0> has store, key {
        id: 0x2::object::UID,
        coins: 0x2::coin::Coin<T0>,
    }

    struct BridgeCapItem<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
    }

    public entry fun add_allowed_coin<T0>(arg0: &mut BridgeData, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 || v0 == arg0.admin_1 || v0 == arg0.admin_2, 3);
        0x2::table::add<0x1::string::String, u64>(&mut arg0.allowed_coins, get_token_name<T0>(), 0x2::table::length<0x1::string::String, u64>(&arg0.allowed_coins));
    }

    public entry fun add_bridge_cap_item<T0>(arg0: &mut BridgeData, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 3);
        let v0 = BridgeCapItem<T0>{
            id       : 0x2::object::new(arg2),
            mint_cap : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg1),
        };
        0x2::dynamic_object_field::add<0x1::string::String, BridgeCapItem<T0>>(&mut arg0.id, get_token_name<T0>(), v0);
    }

    public entry fun add_network_type(arg0: &mut BridgeData, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 || v0 == arg0.admin_1 || v0 == arg0.admin_2, 3);
        0x2::table::add<u64, 0x1::string::String>(&mut arg0.to_network, arg1, arg2);
    }

    public entry fun bridge_token<T0>(arg0: &mut BridgeData, arg1: 0x1::string::String, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_token_name<T0>();
        assert!(arg2 == 0x2::coin::value<T0>(&arg3), 2);
        assert!(0x2::table::contains<u64, 0x1::string::String>(&arg0.to_network, arg4), 1);
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.allowed_coins, v0), 4);
        if (!0x2::dynamic_object_field::exists_with_type<0x1::string::String, BridgeItem<T0>>(&arg0.id, v0)) {
            let v1 = BridgeItem<T0>{
                id    : 0x2::object::new(arg6),
                coins : 0x2::coin::zero<T0>(arg6),
            };
            0x2::dynamic_object_field::add<0x1::string::String, BridgeItem<T0>>(&mut arg0.id, v0, v1);
        };
        0x2::coin::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, BridgeItem<T0>>(&mut arg0.id, v0).coins, arg3);
        arg0.current_id = arg0.current_id + 1;
        let v2 = LockAssetTokenEvent{
            uid             : arg0.current_id,
            amount          : arg2,
            locked_time     : 0x2::clock::timestamp_ms(arg5),
            coin_type       : v0,
            to_network_type : arg4,
            sender          : 0x2::tx_context::sender(arg6),
            to_address      : arg1,
        };
        0x2::event::emit<LockAssetTokenEvent>(v2);
    }

    public entry fun burn_to_bridge_token<T0>(arg0: &mut BridgeData, arg1: 0x1::string::String, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_token_name<T0>();
        assert!(arg2 == 0x2::coin::value<T0>(&arg3), 2);
        assert!(0x2::table::contains<u64, 0x1::string::String>(&arg0.to_network, arg4), 1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, BridgeCapItem<T0>>(&mut arg0.id, v0);
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&v1.mint_cap), 5);
        0x2::coin::burn<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut v1.mint_cap), arg3);
        arg0.current_id = arg0.current_id + 1;
        let v2 = BurnToBridgeTokenEvent{
            uid             : arg0.current_id,
            amount          : arg2,
            start_at        : 0x2::clock::timestamp_ms(arg5),
            coin_type       : v0,
            to_network_type : arg4,
            sender          : 0x2::tx_context::sender(arg6),
            to_address      : arg1,
        };
        0x2::event::emit<BurnToBridgeTokenEvent>(v2);
    }

    public entry fun deposit_asset_token<T0>(arg0: &mut BridgeData, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 || v0 == arg0.admin_1 || v0 == arg0.admin_2, 3);
        let v1 = get_token_name<T0>();
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.allowed_coins, v1), 4);
        assert!(arg1 == 0x2::coin::value<T0>(&arg2), 2);
        if (!0x2::dynamic_object_field::exists_with_type<0x1::string::String, BridgeItem<T0>>(&arg0.id, v1)) {
            let v2 = BridgeItem<T0>{
                id    : 0x2::object::new(arg3),
                coins : 0x2::coin::zero<T0>(arg3),
            };
            0x2::dynamic_object_field::add<0x1::string::String, BridgeItem<T0>>(&mut arg0.id, v1, v2);
        };
        0x2::coin::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, BridgeItem<T0>>(&mut arg0.id, v1).coins, arg2);
    }

    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeData{
            id              : 0x2::object::new(arg0),
            admin_1         : @0x37f7656c0c1862dc5ae3e66effd019500616937f2248e944012a3baa7f4d62f8,
            admin_2         : @0x233,
            total_coin_type : 0,
            to_network      : 0x2::table::new<u64, 0x1::string::String>(arg0),
            allowed_coins   : 0x2::table::new<0x1::string::String, u64>(arg0),
            current_id      : 0,
        };
        0x2::table::add<u64, 0x1::string::String>(&mut v0.to_network, 2, 0x1::string::utf8(b"Aptos"));
        0x2::transfer::public_share_object<BridgeData>(v0);
    }

    public entry fun mint_to_transfer_coin_for_address<T0>(arg0: &mut BridgeData, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin_1, 3);
        let v0 = get_token_name<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, BridgeCapItem<T0>>(&mut arg0.id, v0);
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&v1.mint_cap), 5);
        0x2::coin::mint_and_transfer<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut v1.mint_cap), arg2, arg1, arg4);
        let v2 = MintToTransferTokenEvent{
            amount          : arg2,
            transfered_time : 0x2::clock::timestamp_ms(arg3),
            coin_type       : v0,
            to_address      : arg1,
        };
        0x2::event::emit<MintToTransferTokenEvent>(v2);
    }

    public entry fun set_admin_1(arg0: &mut BridgeData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 3);
        arg0.admin_1 = arg1;
    }

    public entry fun set_admin_2(arg0: &mut BridgeData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 3);
        arg0.admin_2 = arg1;
    }

    public entry fun transfer_coin_to_address<T0>(arg0: &mut BridgeData, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin_1, 3);
        let v0 = get_token_name<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, BridgeItem<T0>>(&mut arg0.id, v0);
        assert!(0x2::coin::value<T0>(&v1.coins) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1.coins, arg2, arg4), arg1);
        let v2 = TransferAssetTokenEvent{
            amount          : arg2,
            transfered_time : 0x2::clock::timestamp_ms(arg3),
            coin_type       : v0,
            to_address      : arg1,
        };
        0x2::event::emit<TransferAssetTokenEvent>(v2);
    }

    public entry fun withdraw_asset<T0>(arg0: &mut BridgeData, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 || v0 == arg0.admin_1 || v0 == arg0.admin_2, 3);
        let v1 = get_token_name<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, BridgeItem<T0>>(&mut arg0.id, v1);
        let v3 = 0x2::coin::value<T0>(&v2.coins);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v2.coins, v3, arg2), v0);
        let v4 = WithdrawEvent{
            amount        : v3,
            coin_type     : v1,
            withdraw_time : 0x2::clock::timestamp_ms(arg1),
            to            : v0,
        };
        0x2::event::emit<WithdrawEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

