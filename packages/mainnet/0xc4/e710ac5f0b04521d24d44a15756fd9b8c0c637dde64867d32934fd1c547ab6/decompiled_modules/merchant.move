module 0xc4e710ac5f0b04521d24d44a15756fd9b8c0c637dde64867d32934fd1c547ab6::merchant {
    struct AdminConfig has key {
        id: 0x2::object::UID,
        admin: address,
        shop_creation_fee: u64,
        purchase_fee: u64,
        admin_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TokenInfo has copy, drop, store {
        token_id: u64,
        token_type: 0x1::ascii::String,
        price_in_sui: u64,
    }

    struct MerchantShop has key {
        id: 0x2::object::UID,
        owner: address,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        token_balances: 0x2::bag::Bag,
        item_count: u64,
        accepted_tokens: vector<u64>,
        is_active: bool,
    }

    struct MerchantItem has store, key {
        id: 0x2::object::UID,
        item_id: u64,
        price_in_sui: u64,
        token_id: u64,
        quantity: u64,
        sold_count: u64,
        is_active: bool,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        tokens: 0x2::vec_map::VecMap<u64, TokenInfo>,
        next_token_id: u64,
    }

    struct AdminConfigCreated has copy, drop {
        admin: address,
        shop_creation_fee: u64,
        purchase_fee: u64,
    }

    struct ShopCreated has copy, drop {
        shop_id: 0x2::object::ID,
        owner: address,
    }

    struct ShopDeleted has copy, drop {
        shop_id: 0x2::object::ID,
        owner: address,
    }

    struct ItemCreated has copy, drop {
        item_id: u64,
        price_in_sui: u64,
        token_id: u64,
        quantity: u64,
    }

    struct ItemPurchased has copy, drop {
        item_id: u64,
        buyer: address,
        price_paid: u64,
        fee_collected: u64,
        payment_token_id: u64,
    }

    struct ItemStatusChanged has copy, drop {
        item_id: u64,
        is_active: bool,
    }

    struct TokenRegistered has copy, drop {
        token_id: u64,
        token_type: 0x1::ascii::String,
        price_in_sui: u64,
    }

    struct FeesUpdated has copy, drop {
        shop_creation_fee: u64,
        purchase_fee: u64,
    }

    struct TokensConfigured has copy, drop {
        shop_id: 0x2::object::ID,
        accepted_tokens: vector<u64>,
    }

    struct TokenWithdrawn has copy, drop {
        shop_id: 0x2::object::ID,
        token_id: u64,
        amount: u64,
    }

    struct ItemRefunded has copy, drop {
        item_id: u64,
        buyer: address,
        refund_amount: u64,
        payment_token_id: u64,
    }

    public fun add_accepted_token(arg0: &mut MerchantShop, arg1: u64, arg2: &TokenRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        validate_token_exists(arg2, arg1);
        if (!0x1::vector::contains<u64>(&arg0.accepted_tokens, &arg1)) {
            0x1::vector::push_back<u64>(&mut arg0.accepted_tokens, arg1);
            let v0 = TokensConfigured{
                shop_id         : 0x2::object::uid_to_inner(&arg0.id),
                accepted_tokens : arg0.accepted_tokens,
            };
            0x2::event::emit<TokensConfigured>(v0);
        };
    }

    public fun admin_create_shop(arg0: &AdminConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 5);
        let v0 = create_shop_internal(arg1, arg2);
        emit_shop_created(0x2::object::uid_to_inner(&v0.id), arg1);
        0x2::transfer::share_object<MerchantShop>(v0);
    }

    fun calculate_required_tokens(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / arg1;
        let v1 = v0;
        if (arg0 % arg1 != 0) {
            v1 = v0 + 1;
        };
        v1
    }

    fun check_token_accepted(arg0: &MerchantShop, arg1: u64) {
        if (0x1::vector::length<u64>(&arg0.accepted_tokens) > 0) {
            assert!(0x1::vector::contains<u64>(&arg0.accepted_tokens, &arg1), 8);
        };
    }

    public fun configure_accepted_tokens(arg0: &mut MerchantShop, arg1: vector<u64>, arg2: &TokenRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            validate_token_exists(arg2, *0x1::vector::borrow<u64>(&arg1, v0));
            v0 = v0 + 1;
        };
        arg0.accepted_tokens = arg1;
        let v1 = TokensConfigured{
            shop_id         : 0x2::object::uid_to_inner(&arg0.id),
            accepted_tokens : arg1,
        };
        0x2::event::emit<TokensConfigured>(v1);
    }

    public fun create_item(arg0: &mut MerchantShop, arg1: u64, arg2: u64, arg3: u64, arg4: &TokenRegistry, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 4);
        assert!(arg0.is_active, 2);
        assert!(arg1 > 0, 1);
        assert!(arg3 <= 1000000, 11);
        assert!(arg0.item_count < 1000000000, 14);
        validate_token_exists(arg4, arg2);
        check_token_accepted(arg0, arg2);
        arg0.item_count = arg0.item_count + 1;
        let v0 = MerchantItem{
            id           : 0x2::object::new(arg5),
            item_id      : arg0.item_count,
            price_in_sui : arg1,
            token_id     : arg2,
            quantity     : arg3,
            sold_count   : 0,
            is_active    : true,
        };
        let v1 = ItemCreated{
            item_id      : arg0.item_count,
            price_in_sui : arg1,
            token_id     : arg2,
            quantity     : arg3,
        };
        0x2::event::emit<ItemCreated>(v1);
        0x2::transfer::public_transfer<MerchantItem>(v0, arg0.owner);
    }

    public fun create_shop(arg0: &mut AdminConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.shop_creation_fee, 7);
        process_fee_payment(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = create_shop_internal(v0, arg2);
        emit_shop_created(0x2::object::uid_to_inner(&v1.id), 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<MerchantShop>(v1);
    }

    fun create_shop_internal(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : MerchantShop {
        MerchantShop{
            id              : 0x2::object::new(arg1),
            owner           : arg0,
            balance_sui     : 0x2::balance::zero<0x2::sui::SUI>(),
            token_balances  : 0x2::bag::new(arg1),
            item_count      : 0,
            accepted_tokens : 0x1::vector::empty<u64>(),
            is_active       : true,
        }
    }

    public fun delete_shop(arg0: MerchantShop, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
        assert!(!arg0.is_active, 13);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui) == 0, 13);
        assert!(0x2::bag::is_empty(&arg0.token_balances), 13);
        let MerchantShop {
            id              : v0,
            owner           : v1,
            balance_sui     : v2,
            token_balances  : v3,
            item_count      : _,
            accepted_tokens : _,
            is_active       : _,
        } = arg0;
        let v7 = v0;
        let v8 = ShopDeleted{
            shop_id : 0x2::object::uid_to_inner(&v7),
            owner   : v1,
        };
        0x2::event::emit<ShopDeleted>(v8);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        0x2::bag::destroy_empty(v3);
        0x2::object::delete(v7);
    }

    fun emit_shop_created(arg0: 0x2::object::ID, arg1: address) {
        let v0 = ShopCreated{
            shop_id : arg0,
            owner   : arg1,
        };
        0x2::event::emit<ShopCreated>(v0);
    }

    public fun get_accepted_tokens(arg0: &MerchantShop) : vector<u64> {
        arg0.accepted_tokens
    }

    public fun get_admin_balance(arg0: &AdminConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.admin_balance)
    }

    public fun get_item_id(arg0: &MerchantItem) : u64 {
        arg0.item_id
    }

    public fun get_item_price(arg0: &MerchantItem) : u64 {
        arg0.price_in_sui
    }

    public fun get_item_quantity(arg0: &MerchantItem) : u64 {
        arg0.quantity
    }

    public fun get_purchase_fee(arg0: &AdminConfig) : u64 {
        arg0.purchase_fee
    }

    public fun get_remaining_quantity(arg0: &MerchantItem) : u64 {
        if (arg0.quantity == 0) {
            return 0
        };
        arg0.quantity - arg0.sold_count
    }

    public fun get_shop_balance(arg0: &MerchantShop) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui)
    }

    public fun get_shop_creation_fee(arg0: &AdminConfig) : u64 {
        arg0.shop_creation_fee
    }

    public fun get_sold_count(arg0: &MerchantItem) : u64 {
        arg0.sold_count
    }

    public fun get_token_id(arg0: &MerchantItem) : u64 {
        arg0.token_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminConfig{
            id                : 0x2::object::new(arg0),
            admin             : @0x1aa37f62ff54936597cc044c98aa6f01860968455f41be63ecce0dea7b439451,
            shop_creation_fee : 10000000000,
            purchase_fee      : 50000000,
            admin_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = AdminConfigCreated{
            admin             : @0x1aa37f62ff54936597cc044c98aa6f01860968455f41be63ecce0dea7b439451,
            shop_creation_fee : 10000000000,
            purchase_fee      : 50000000,
        };
        0x2::event::emit<AdminConfigCreated>(v1);
        0x2::transfer::share_object<AdminConfig>(v0);
        let v2 = TokenRegistry{
            id            : 0x2::object::new(arg0),
            tokens        : 0x2::vec_map::empty<u64, TokenInfo>(),
            next_token_id : 1,
        };
        0x2::transfer::share_object<TokenRegistry>(v2);
    }

    public fun is_item_active(arg0: &MerchantItem) : bool {
        arg0.is_active
    }

    public fun is_shop_active(arg0: &MerchantShop) : bool {
        arg0.is_active
    }

    public fun is_token_accepted(arg0: &MerchantShop, arg1: u64) : bool {
        if (0x1::vector::length<u64>(&arg0.accepted_tokens) == 0) {
            return true
        };
        0x1::vector::contains<u64>(&arg0.accepted_tokens, &arg1)
    }

    fun process_fee_payment(arg0: &mut AdminConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun purchase_item_with_sui(arg0: &mut AdminConfig, arg1: &mut MerchantShop, arg2: &mut MerchantItem, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        validate_item_purchase(arg1, arg2);
        assert!(arg2.token_id == 0, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg2.price_in_sui + arg0.purchase_fee, 3);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.purchase_fee));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance_sui, v0);
        update_item_after_purchase(arg2);
        let v1 = ItemPurchased{
            item_id          : arg2.item_id,
            buyer            : 0x2::tx_context::sender(arg4),
            price_paid       : arg2.price_in_sui,
            fee_collected    : arg0.purchase_fee,
            payment_token_id : 0,
        };
        0x2::event::emit<ItemPurchased>(v1);
    }

    public fun purchase_item_with_token<T0>(arg0: &mut AdminConfig, arg1: &mut MerchantShop, arg2: &mut MerchantItem, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &TokenRegistry, arg6: &mut 0x2::tx_context::TxContext) {
        validate_item_purchase(arg1, arg2);
        assert!(arg2.token_id != 0, 10);
        assert!(0x2::vec_map::contains<u64, TokenInfo>(&arg5.tokens, &arg2.token_id), 6);
        let v0 = 0x2::vec_map::get<u64, TokenInfo>(&arg5.tokens, &arg2.token_id);
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == v0.token_type, 15);
        assert!(0x2::coin::value<T0>(&arg3) >= calculate_required_tokens(arg2.price_in_sui, v0.price_in_sui), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg0.purchase_fee, 7);
        process_fee_payment(arg0, arg4);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg1.token_balances, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.token_balances, v1), 0x2::coin::into_balance<T0>(arg3));
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.token_balances, v1, 0x2::coin::into_balance<T0>(arg3));
        };
        update_item_after_purchase(arg2);
        let v2 = ItemPurchased{
            item_id          : arg2.item_id,
            buyer            : 0x2::tx_context::sender(arg6),
            price_paid       : arg2.price_in_sui,
            fee_collected    : arg0.purchase_fee,
            payment_token_id : arg2.token_id,
        };
        0x2::event::emit<ItemPurchased>(v2);
    }

    public fun refund_purchase_sui(arg0: &mut MerchantShop, arg1: &mut MerchantItem, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        assert!(arg1.token_id == 0, 10);
        let v0 = arg1.price_in_sui;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui) >= v0, 16);
        if (arg1.sold_count > 0) {
            arg1.sold_count = arg1.sold_count - 1;
        };
        if (arg1.quantity > 0 && !arg1.is_active) {
            arg1.is_active = true;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance_sui, v0, arg3), arg2);
        let v1 = ItemRefunded{
            item_id          : arg1.item_id,
            buyer            : arg2,
            refund_amount    : v0,
            payment_token_id : 0,
        };
        0x2::event::emit<ItemRefunded>(v1);
    }

    public fun refund_purchase_token<T0>(arg0: &mut MerchantShop, arg1: &mut MerchantItem, arg2: address, arg3: &TokenRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 4);
        assert!(arg1.token_id != 0, 10);
        assert!(0x2::vec_map::contains<u64, TokenInfo>(&arg3.tokens, &arg1.token_id), 6);
        let v0 = 0x2::vec_map::get<u64, TokenInfo>(&arg3.tokens, &arg1.token_id);
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == v0.token_type, 15);
        let v1 = calculate_required_tokens(arg1.price_in_sui, v0.price_in_sui);
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.token_balances, v2), 6);
        let v3 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.token_balances, v2);
        assert!(0x2::balance::value<T0>(v3) >= v1, 16);
        if (arg1.sold_count > 0) {
            arg1.sold_count = arg1.sold_count - 1;
        };
        if (arg1.quantity > 0 && !arg1.is_active) {
            arg1.is_active = true;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v3, v1, arg4), arg2);
        let v4 = ItemRefunded{
            item_id          : arg1.item_id,
            buyer            : arg2,
            refund_amount    : arg1.price_in_sui,
            payment_token_id : arg1.token_id,
        };
        0x2::event::emit<ItemRefunded>(v4);
    }

    public fun register_token<T0>(arg0: &mut TokenRegistry, arg1: u64, arg2: &AdminConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.admin, 5);
        assert!(arg1 > 0, 1);
        let v0 = arg0.next_token_id;
        assert!(v0 < 18446744073709551615, 14);
        arg0.next_token_id = v0 + 1;
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = TokenInfo{
            token_id     : v0,
            token_type   : v1,
            price_in_sui : arg1,
        };
        0x2::vec_map::insert<u64, TokenInfo>(&mut arg0.tokens, v0, v2);
        let v3 = TokenRegistered{
            token_id     : v0,
            token_type   : v1,
            price_in_sui : arg1,
        };
        0x2::event::emit<TokenRegistered>(v3);
    }

    public fun remove_accepted_token(arg0: &mut MerchantShop, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.accepted_tokens, &arg1);
        if (v0) {
            0x1::vector::remove<u64>(&mut arg0.accepted_tokens, v1);
            let v2 = TokensConfigured{
                shop_id         : 0x2::object::uid_to_inner(&arg0.id),
                accepted_tokens : arg0.accepted_tokens,
            };
            0x2::event::emit<TokensConfigured>(v2);
        };
    }

    public fun set_item_status(arg0: &MerchantShop, arg1: &mut MerchantItem, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        if (arg2 && arg1.quantity > 0) {
            assert!(arg1.sold_count < arg1.quantity, 12);
        };
        arg1.is_active = arg2;
        let v0 = ItemStatusChanged{
            item_id   : arg1.item_id,
            is_active : arg2,
        };
        0x2::event::emit<ItemStatusChanged>(v0);
    }

    public fun set_shop_status(arg0: &mut MerchantShop, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.is_active = arg1;
    }

    public fun update_fees(arg0: &mut AdminConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 5);
        arg0.shop_creation_fee = arg1;
        arg0.purchase_fee = arg2;
        let v0 = FeesUpdated{
            shop_creation_fee : arg1,
            purchase_fee      : arg2,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    fun update_item_after_purchase(arg0: &mut MerchantItem) {
        arg0.sold_count = arg0.sold_count + 1;
        if (arg0.quantity > 0 && arg0.sold_count >= arg0.quantity) {
            arg0.is_active = false;
        };
    }

    public fun update_price(arg0: &MerchantShop, arg1: &mut MerchantItem, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        assert!(arg2 > 0, 1);
        arg1.price_in_sui = arg2;
    }

    public fun update_quantity(arg0: &MerchantShop, arg1: &mut MerchantItem, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 4);
        assert!(arg2 <= 1000000, 11);
        assert!(arg2 >= arg1.sold_count, 11);
        arg1.quantity = arg2;
        if (arg2 > 0 && arg1.sold_count >= arg2) {
            arg1.is_active = false;
        };
    }

    public fun update_token_price(arg0: &mut TokenRegistry, arg1: u64, arg2: u64, arg3: &AdminConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg3.admin, 5);
        assert!(arg1 != 0, 9);
        assert!(arg2 > 0, 1);
        assert!(0x2::vec_map::contains<u64, TokenInfo>(&arg0.tokens, &arg1), 6);
        0x2::vec_map::get_mut<u64, TokenInfo>(&mut arg0.tokens, &arg1).price_in_sui = arg2;
    }

    fun validate_item_purchase(arg0: &MerchantShop, arg1: &MerchantItem) {
        assert!(arg0.is_active, 2);
        assert!(arg1.is_active, 2);
        if (arg1.quantity > 0) {
            assert!(arg1.sold_count < arg1.quantity, 12);
        };
    }

    fun validate_token_exists(arg0: &TokenRegistry, arg1: u64) {
        if (arg1 != 0) {
            assert!(0x2::vec_map::contains<u64, TokenInfo>(&arg0.tokens, &arg1), 6);
        };
    }

    public fun withdraw_admin_fees(arg0: &mut AdminConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 5);
        let v0 = if (arg1 == 0) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.admin_balance)
        } else {
            arg1
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.admin_balance, v0, arg2), arg0.admin);
        };
    }

    public fun withdraw_sui(arg0: &mut MerchantShop, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        let v0 = if (arg1 == 0) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui)
        } else {
            arg1
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance_sui, v0, arg2), arg0.owner);
        };
    }

    public fun withdraw_token<T0>(arg0: &mut MerchantShop, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.token_balances, v0), 6);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.token_balances, v0);
        let v2 = if (arg1 == 0) {
            0x2::balance::value<T0>(v1)
        } else {
            arg1
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, v2, arg2), arg0.owner);
            let v3 = TokenWithdrawn{
                shop_id  : 0x2::object::uid_to_inner(&arg0.id),
                token_id : 0,
                amount   : v2,
            };
            0x2::event::emit<TokenWithdrawn>(v3);
        };
    }

    // decompiled from Move bytecode v6
}

