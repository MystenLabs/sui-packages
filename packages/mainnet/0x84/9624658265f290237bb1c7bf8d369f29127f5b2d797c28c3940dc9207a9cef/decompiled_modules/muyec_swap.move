module 0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::muyec_swap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Bank has store, key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>,
        coin_b: 0x2::balance::Balance<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>,
    }

    public entry fun deposit_a(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>(&mut arg0.coin_a, 0x2::coin::into_balance<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>(arg1));
    }

    public entry fun deposit_b(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>(&mut arg0.coin_b, 0x2::coin::into_balance<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>(),
            coin_b : 0x2::balance::zero<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_a_b(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>(&mut arg0.coin_a, 0x2::coin::into_balance<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>>(0x2::coin::from_balance<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>(0x2::balance::split<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>(&mut arg0.coin_b, 0x2::coin::value<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>(&arg1) / 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_a(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>(&mut arg0.coin_b, 0x2::coin::into_balance<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>>(0x2::coin::from_balance<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>(0x2::balance::split<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>(&mut arg0.coin_a, 0x2::coin::value<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>(&arg1) * 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_a(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>>(0x2::coin::from_balance<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>(0x2::balance::split<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_a::COIN_A>(&mut arg1.coin_a, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_b(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>>(0x2::coin::from_balance<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>(0x2::balance::split<0x849624658265f290237bb1c7bf8d369f29127f5b2d797c28c3940dc9207a9cef::coin_b::COIN_B>(&mut arg1.coin_b, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

