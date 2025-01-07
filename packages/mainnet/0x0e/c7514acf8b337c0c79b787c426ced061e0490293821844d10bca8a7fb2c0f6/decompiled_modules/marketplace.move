module 0xec7514acf8b337c0c79b787c426ced061e0490293821844d10bca8a7fb2c0f6::marketplace {
    struct Marketplace<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        payments: 0x2::table::Table<address, 0x2::coin::Coin<T0>>,
    }

    fun buy<T0>(arg0: &mut Marketplace<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0xec7514acf8b337c0c79b787c426ced061e0490293821844d10bca8a7fb2c0f6::widget::DevNetNFT {
        0xec7514acf8b337c0c79b787c426ced061e0490293821844d10bca8a7fb2c0f6::widget::mint(arg1, arg2, arg3, arg4)
    }

    public entry fun buy_and_take<T0>(arg0: &mut Marketplace<T0>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(5000000000 == 0x2::coin::value<T0>(&arg5), 0);
        0x2::table::add<address, 0x2::coin::Coin<T0>>(&mut arg0.payments, arg0.owner, arg5);
        let v0 = buy<T0>(arg0, arg2, arg3, arg4, arg6);
        0x2::transfer::public_transfer<0xec7514acf8b337c0c79b787c426ced061e0490293821844d10bca8a7fb2c0f6::widget::DevNetNFT>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace<T0>{
            id       : 0x2::object::new(arg0),
            owner    : 0x2::tx_context::sender(arg0),
            payments : 0x2::table::new<address, 0x2::coin::Coin<T0>>(arg0),
        };
        0x2::transfer::share_object<Marketplace<T0>>(v0);
    }

    fun take_profits<T0>(arg0: &mut Marketplace<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::table::remove<address, 0x2::coin::Coin<T0>>(&mut arg0.payments, 0x2::tx_context::sender(arg1))
    }

    public entry fun take_profits_and_keep<T0>(arg0: &mut Marketplace<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = take_profits<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

