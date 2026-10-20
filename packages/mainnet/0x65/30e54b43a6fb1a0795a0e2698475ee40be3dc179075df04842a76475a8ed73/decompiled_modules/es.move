module 0x6530e54b43a6fb1a0795a0e2698475ee40be3dc179075df04842a76475a8ed73::es {
    public fun ab<T0, T1>(arg0: &mut 0xafd06ed69a706eabb66f2a1f9305afc0a317ae95e5bfe8ae9868b23b17f7887b::orderbook::Orderbook, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::tx_context::sender(arg4) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
        let v0 = 0xafd06ed69a706eabb66f2a1f9305afc0a317ae95e5bfe8ae9868b23b17f7887b::orderbook::get_order(arg0, arg1);
        let v1 = (0xafd06ed69a706eabb66f2a1f9305afc0a317ae95e5bfe8ae9868b23b17f7887b::order::making_amount(v0) as u128);
        let v2 = (0xafd06ed69a706eabb66f2a1f9305afc0a317ae95e5bfe8ae9868b23b17f7887b::order::taking_amount(v0) as u128);
        let v3 = 0xafd06ed69a706eabb66f2a1f9305afc0a317ae95e5bfe8ae9868b23b17f7887b::order::remaining_amount(v0);
        let v4 = (((0x2::balance::value<T0>(&arg3) as u128) * v1 / v2) as u64);
        let v5 = v4;
        if (v4 > v3) {
            v5 = v3;
        };
        let (v6, v7) = 0xafd06ed69a706eabb66f2a1f9305afc0a317ae95e5bfe8ae9868b23b17f7887b::orderbook::take_order<T1>(arg0, arg1, v5, arg2, arg4);
        let v8 = 0x2::coin::from_balance<T0>(arg3, arg4);
        0xafd06ed69a706eabb66f2a1f9305afc0a317ae95e5bfe8ae9868b23b17f7887b::orderbook::fill_order<T0>(arg0, v7, 0x2::coin::split<T0>(&mut v8, ((((v5 as u128) * v2 + v1 - 1) / v1) as u64), arg4), arg4);
        if (0x2::coin::value<T0>(&v8) == 0) {
            0x2::coin::destroy_zero<T0>(v8);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380);
        };
        0x2::coin::into_balance<T1>(v6)
    }

    // decompiled from Move bytecode v7
}

