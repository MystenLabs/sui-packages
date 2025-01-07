module 0x366a0d36de7f513a10ce7464781f503cf37784ec111a67eefa9b934120196106::sp {
    struct CoinWallet<phantom T0> has key {
        id: 0x2::object::UID,
        token: 0x2::balance::Balance<T0>,
    }

    struct WhiteList has key {
        id: 0x2::object::UID,
        address_list: vector<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun a_w_l(arg0: &AdminCap, arg1: &mut WhiteList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg1.address_list, arg2);
    }

    fun add_coin_to_vector<T0>(arg0: 0x2::coin::Coin<T0>) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        v0
    }

    public fun c_c_w<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinWallet<T0>{
            id    : 0x2::object::new(arg1),
            token : 0x2::coin::into_balance<T0>(0x2::coin::zero<T0>(arg1)),
        };
        0x2::transfer::share_object<CoinWallet<T0>>(v0);
    }

    public entry fun d<T0>(arg0: &mut CoinWallet<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
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

    public fun s<T0, T1>(arg0: &WhiteList, arg1: &mut CoinWallet<T0>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        white_list_check(arg0, &v0);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input<T0, T1>(arg6, arg7, 0x2::coin::take<T0>(&mut arg1.token, arg2, arg8), arg3, arg4, arg5, arg8);
    }

    public fun s_d<T0, T1, T2>(arg0: &WhiteList, arg1: &mut CoinWallet<T0>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        white_list_check(arg0, &v0);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_doublehop<T0, T1, T2>(arg6, arg7, 0x2::coin::take<T0>(&mut arg1.token, arg2, arg8), arg3, arg4, arg5, arg8);
    }

    public fun s_t<T0, T1, T2, T3>(arg0: &WhiteList, arg1: &mut CoinWallet<T0>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        white_list_check(arg0, &v0);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_triplehop<T0, T1, T2, T3>(arg6, arg7, 0x2::coin::take<T0>(&mut arg1.token, arg2, arg8), arg3, arg4, arg5, arg8);
    }

    public entry fun w<T0>(arg0: &AdminCap, arg1: &mut CoinWallet<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.token) >= arg2, 501);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.token, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun white_list_check(arg0: &WhiteList, arg1: &address) {
        assert!(0x1::vector::contains<address>(&arg0.address_list, arg1), 503);
    }

    // decompiled from Move bytecode v6
}

