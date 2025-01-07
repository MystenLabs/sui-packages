module 0x638ab8312d60a29a189b83035a54a426c925cd3c0a5c72d5887ebcd085017c67::holder {
    struct Holding<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct HoldingCreated has copy, drop {
        holding_id: 0x2::object::ID,
    }

    public fun get<T0>(arg0: &mut Holding<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_whitelisted(arg2), 31415);
        0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2)
    }

    public fun hold<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = HoldingCreated{holding_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<HoldingCreated>(v1);
        let v2 = Holding<T0>{
            id      : v0,
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<Holding<T0>>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun is_whitelisted(arg0: &mut 0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg0) == @0x84276c0c004b538687cabbc89ce68a8cc60e6202ec27c227afdb998e4234491b || 0x2::tx_context::sender(arg0) == @0x58571b065f05c1472c16341b438870b851dc87bd56d80ddc59e8e00364f6bb6c || 0x2::tx_context::sender(arg0) == @0xfbe8f5b928e9235f80c73d690cf5adf34f69c3ca0182c234925ad8e679eef566 || 0x2::tx_context::sender(arg0) == @0xd19dc183c90a2cf7e9ba53bf31968c0d5bbb2e65fa46ca8f50761471a1cecf37 || 0x2::tx_context::sender(arg0) == @0xcf4898fcd07d4f51c3d3bff215d47a322aba67fd61978daa5080d8469eb03717 || 0x2::tx_context::sender(arg0) == @0x6bf6749e65dc0888ae77f1e200bffb2f68bb1fc07453df8efb8eed49b11c22e8 || 0x2::tx_context::sender(arg0) == @0x336849efb012276c606cb38aa87d92601ba089c9da0f512882b7ef106d934f6d
    }

    // decompiled from Move bytecode v6
}

