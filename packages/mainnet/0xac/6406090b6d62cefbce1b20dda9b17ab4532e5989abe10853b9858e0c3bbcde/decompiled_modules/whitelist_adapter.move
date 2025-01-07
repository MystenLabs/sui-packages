module 0xac6406090b6d62cefbce1b20dda9b17ab4532e5989abe10853b9858e0c3bbcde::whitelist_adapter {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Whitelist has key {
        id: 0x2::object::UID,
        members: 0x2::vec_set::VecSet<address>,
    }

    public fun swap<T0>(arg0: &Whitelist, arg1: &mut 0xc045baf321eb9da099455f05e01226e28302e2e36f824761b93cc6785ee018b4::dca::Request<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &v0), 0);
        resolve<T0>(arg1, arg2);
    }

    public fun remove(arg0: &mut Whitelist, arg1: &0xc045baf321eb9da099455f05e01226e28302e2e36f824761b93cc6785ee018b4::dca::Admin, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.members, &arg2);
    }

    public fun add(arg0: &mut Whitelist, arg1: &0xc045baf321eb9da099455f05e01226e28302e2e36f824761b93cc6785ee018b4::dca::Admin, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.members, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Whitelist{
            id      : 0x2::object::new(arg0),
            members : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Whitelist>(v0);
    }

    fun resolve<T0>(arg0: &mut 0xc045baf321eb9da099455f05e01226e28302e2e36f824761b93cc6785ee018b4::dca::Request<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = Witness{dummy_field: false};
        0xc045baf321eb9da099455f05e01226e28302e2e36f824761b93cc6785ee018b4::dca::add<Witness, T0>(arg0, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

