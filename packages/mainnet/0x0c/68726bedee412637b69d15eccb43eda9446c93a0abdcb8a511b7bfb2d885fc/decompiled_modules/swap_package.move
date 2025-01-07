module 0xc68726bedee412637b69d15eccb43eda9446c93a0abdcb8a511b7bfb2d885fc::swap_package {
    struct CoinWallet<phantom T0> has key {
        id: 0x2::object::UID,
        token: 0x2::balance::Balance<T0>,
    }

    struct WalletEvent has copy, drop {
        tag: u8,
        balance: u64,
    }

    struct SwapEvent has copy, drop {
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
        sqrt_price_limit: u128,
        recipient: address,
        a_amount: u64,
        b_amount: u64,
    }

    struct SwapRespEvent has copy, drop {
        amount: u64,
        min_out_amount: u64,
        recipient: address,
    }

    struct MsgEvent has copy, drop {
        msg: 0x1::string::String,
        address: address,
    }

    struct WhiteList has key {
        id: 0x2::object::UID,
        address_list: vector<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun swap<T0, T1>(arg0: &WhiteList, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: &mut CoinWallet<T0>, arg3: &mut CoinWallet<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        white_list_check(arg0, &v0);
        let v1 = if (arg4) {
            arg5
        } else {
            0
        };
        let v2 = if (!arg4) {
            arg5
        } else {
            0
        };
        if (arg4) {
            0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::swap_x_to_y<T0, T1>(arg1, add_coin_to_vector<T0>(0x2::coin::take<T0>(&mut arg2.token, v1, arg8)), arg5, arg6, arg7, arg8);
        } else {
            0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::swap_y_to_x<T0, T1>(arg1, add_coin_to_vector<T1>(0x2::coin::take<T1>(&mut arg3.token, v2, arg8)), arg5, arg6, arg7, arg8);
        };
    }

    fun add_coin_to_vector<T0>(arg0: 0x2::coin::Coin<T0>) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        v0
    }

    public fun add_white_list(arg0: &AdminCap, arg1: &mut WhiteList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg1.address_list, arg2);
    }

    public fun create_coin_wallet<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinWallet<T0>{
            id    : 0x2::object::new(arg1),
            token : 0x2::coin::into_balance<T0>(0x2::coin::zero<T0>(arg1)),
        };
        0x2::transfer::share_object<CoinWallet<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut CoinWallet<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinWallet<0x2::sui::SUI>{
            id    : 0x2::object::new(arg0),
            token : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::zero<0x2::sui::SUI>(arg0)),
        };
        0x2::transfer::share_object<CoinWallet<0x2::sui::SUI>>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, 0x2::tx_context::sender(arg0));
        let v3 = WhiteList{
            id           : 0x2::object::new(arg0),
            address_list : v2,
        };
        0x2::transfer::share_object<WhiteList>(v3);
    }

    fun white_list_check(arg0: &WhiteList, arg1: &address) {
        0x1::vector::contains<address>(&arg0.address_list, arg1);
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut CoinWallet<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.token) >= arg2, 501);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.token, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

