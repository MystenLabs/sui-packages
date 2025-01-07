module 0xaf50f18f8baa659505593ff5b2cad157bd04408efd4f915fcabce1b69711b6be::holder {
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
        0x2::tx_context::sender(arg0) == @0x84276c0c004b538687cabbc89ce68a8cc60e6202ec27c227afdb998e4234491b || 0x2::tx_context::sender(arg0) == @0x58571b065f05c1472c16341b438870b851dc87bd56d80ddc59e8e00364f6bb6c || 0x2::tx_context::sender(arg0) == @0x170c2b02e324a22238a12db27f60b53d6639990935f2f176fe152a21626a5e11 || 0x2::tx_context::sender(arg0) == @0xe4d6449947bb048138d59b8044ac558294b855b92297ed3f1f483a6d9af14f1e || 0x2::tx_context::sender(arg0) == @0x24848df250c805c2e342c57ba3b9e58972a6840f3964fecf741fadda8e79dd24 || 0x2::tx_context::sender(arg0) == @0x3efca8882362423774bdbac1330e8362f5a31cc8edddba609421537dcdf34bab || 0x2::tx_context::sender(arg0) == @0x3330772f3b86cd8b11a5b6d356dbbd72461ee9d86ccf12fd5e571bd0dbeae9de
    }

    // decompiled from Move bytecode v6
}

