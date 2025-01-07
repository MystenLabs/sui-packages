module 0xc1408a153f949505cf3540f4ee2c85b20c18a3978abdf6e2508c959c95ef2ed8::simple_swap {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>,
        coin_b: 0x2::balance::Balance<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>,
    }

    public entry fun add(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>, arg2: 0x2::coin::Coin<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>(&mut arg0.coin_a, 0x2::coin::into_balance<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>(arg1));
        0x2::balance::join<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>(&mut arg0.coin_b, 0x2::coin::into_balance<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>(arg2));
    }

    public entry fun create_pool(arg0: 0x2::coin::Coin<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>, arg1: 0x2::coin::Coin<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg2),
            coin_a : 0x2::coin::into_balance<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>(arg0),
            coin_b : 0x2::coin::into_balance<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>(arg1),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>(&arg1);
        0x2::balance::join<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>(&mut arg0.coin_a, 0x2::coin::into_balance<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>>(0x2::coin::from_balance<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>(0x2::balance::split<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>(&mut arg0.coin_b, 0x2::balance::value<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>(&arg0.coin_b) * v0 / (0x2::balance::value<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>(&arg0.coin_a) + v0)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_to_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>(&arg1);
        0x2::balance::join<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>(&mut arg0.coin_b, 0x2::coin::into_balance<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>>(0x2::coin::from_balance<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>(0x2::balance::split<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>(&mut arg0.coin_a, 0x2::balance::value<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca::CA>(&arg0.coin_a) * v0 / (0x2::balance::value<0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::cb::CB>(&arg0.coin_b) + v0)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

