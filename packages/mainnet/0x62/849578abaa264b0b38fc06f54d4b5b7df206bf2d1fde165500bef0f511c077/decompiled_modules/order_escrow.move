module 0x62849578abaa264b0b38fc06f54d4b5b7df206bf2d1fde165500bef0f511c077::order_escrow {
    struct OrderEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        order_ref: vector<u8>,
        buyer: address,
        seller: address,
        amount: u64,
        deadline_ms: u64,
        funds: 0x2::balance::Balance<T0>,
        status: u8,
    }

    public(friend) fun assert_typed_order_payment_fee_policy<T0, T1>() {
        assert!(typed_non_sui_order_escrow_exact_fee_policy_ready<T0, T1>(), 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::errors::e_invalid_fee_config());
    }

    fun create_order_escrow_from_coin<T0>(arg0: vector<u8>, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : OrderEscrow<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 != v0, 2);
        let v1 = 0x1::vector::length<u8>(&arg0);
        assert!(v1 > 0 && v1 <= 128, 4);
        assert!(arg3 > 0, 5);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 0, 1);
        OrderEscrow<T0>{
            id          : 0x2::object::new(arg4),
            order_ref   : arg0,
            buyer       : v0,
            seller      : arg1,
            amount      : v2,
            deadline_ms : arg3,
            funds       : 0x2::coin::into_balance<T0>(arg2),
            status      : 1,
        }
    }

    public(friend) fun create_order_escrow_sui(arg0: vector<u8>, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : OrderEscrow<0x2::sui::SUI> {
        assert!(0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::order_payment_assets::is_supported_order_payment_sui_type<0x2::sui::SUI>(), 3);
        create_order_escrow_from_coin<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) entry fun create_order_escrow_sui_entry(arg0: vector<u8>, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<OrderEscrow<0x2::sui::SUI>>(create_order_escrow_sui(arg0, arg1, arg2, arg3, arg4));
    }

    public(friend) fun create_order_escrow_typed_coin<T0, T1>(arg0: vector<u8>, arg1: address, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : OrderEscrow<T1> {
        assert_typed_order_payment_fee_policy<T0, T1>();
        create_order_escrow_from_coin<T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) entry fun create_order_escrow_typed_order_asset_entry<T0>(arg0: vector<u8>, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<OrderEscrow<T0>>(create_order_escrow_typed_coin<T0, T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun release_order_escrow_funds<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.buyer, 7);
        assert!(arg0.status == 1, 6);
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        assert!(v0 > 0, 8);
        arg0.status = 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v0), arg1), arg0.seller);
    }

    public(friend) entry fun release_order_escrow_sui_entry(arg0: &mut OrderEscrow<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        release_order_escrow_funds<0x2::sui::SUI>(arg0, arg1);
    }

    public(friend) fun release_order_escrow_typed_coin<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_policy::order_payment_fee_policy_kind<T0>() == 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_policy::fee_policy_exact_typed_order_asset(), 3);
        release_order_escrow_funds<T0>(arg0, arg1);
    }

    public(friend) entry fun release_order_escrow_typed_order_asset_entry<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        release_order_escrow_typed_coin<T0>(arg0, arg1);
    }

    public(friend) fun typed_non_sui_order_escrow_exact_fee_policy_ready<T0, T1>() : bool {
        0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_policy::order_payment_fee_asset_matches_order_asset<T0, T1>() && 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_policy::order_payment_fee_policy_kind<T1>() == 0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::typed_fee_policy::fee_policy_exact_typed_order_asset()
    }

    public(friend) fun typed_non_sui_order_escrow_stays_closed<T0>() : bool {
        !0x55858d8115cbece75391a600075904c56d0e41807636755ab8f5f67903e0311c::order_payment_assets::is_supported_order_payment_typed_coin_type<T0>()
    }

    // decompiled from Move bytecode v7
}

