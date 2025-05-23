module 0xae944b93ff026d699a9a4e766ffa60be7b22197b8069ca4fa2aac15cfa3ef652::whitelist_adapter {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Whitelist has key {
        id: 0x2::object::UID,
        members: 0x2::vec_set::VecSet<address>,
    }

    public fun swap<T0>(arg0: &Whitelist, arg1: &mut 0x3dbe7f8a980a1b668dc72b8a39453a29595bb82bd6503b256be4b01c29e9c9a4::dca::Request<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg3)), 0);
        resolve<T0>(arg1, arg2);
    }

    public fun add(arg0: &mut Whitelist, arg1: &0x3dbe7f8a980a1b668dc72b8a39453a29595bb82bd6503b256be4b01c29e9c9a4::dca::Admin, arg2: address) {
        0x2::dynamic_field::add<address, u64>(&mut arg0.id, arg2, 1);
    }

    public fun remove(arg0: &mut Whitelist, arg1: &0x3dbe7f8a980a1b668dc72b8a39453a29595bb82bd6503b256be4b01c29e9c9a4::dca::Admin, arg2: address) {
        0x2::dynamic_field::remove<address, u64>(&mut arg0.id, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Whitelist{
            id      : 0x2::object::new(arg0),
            members : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Whitelist>(v0);
    }

    fun resolve<T0>(arg0: &mut 0x3dbe7f8a980a1b668dc72b8a39453a29595bb82bd6503b256be4b01c29e9c9a4::dca::Request<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = Witness{dummy_field: false};
        0x3dbe7f8a980a1b668dc72b8a39453a29595bb82bd6503b256be4b01c29e9c9a4::dca::add<Witness, T0>(arg0, v0, arg1);
    }

    public fun whitelist_add(arg0: &mut Whitelist, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg2)), 0);
        0x2::dynamic_field::add<address, u64>(&mut arg0.id, arg1, 1);
    }

    public fun whitelist_remove(arg0: &mut Whitelist, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg2)), 0);
        0x2::dynamic_field::remove<address, u64>(&mut arg0.id, arg1);
    }

    // decompiled from Move bytecode v6
}

