module 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::factory {
    struct Factory has key {
        id: 0x2::object::UID,
        vaults: vector<0x2::object::ID>,
    }

    public fun create_vault<T0>(arg0: &mut Factory, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::CreatorCap {
        let (v0, v1) = 0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::create_vault<T0>(arg1, arg2, arg3, arg4);
        let v2 = v0;
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.vaults, 0x2::object::id<0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::Vault<T0>>(&v2));
        0x8509610948b6437c3a9dd841af6f1083a3481adaa521625d18c90d08e05b10e9::vault::share_vault<T0>(v2);
        v1
    }

    public fun get_vault_count(arg0: &Factory) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.vaults)
    }

    public fun get_vaults(arg0: &Factory) : vector<0x2::object::ID> {
        arg0.vaults
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id     : 0x2::object::new(arg0),
            vaults : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Factory>(v0);
    }

    // decompiled from Move bytecode v7
}

