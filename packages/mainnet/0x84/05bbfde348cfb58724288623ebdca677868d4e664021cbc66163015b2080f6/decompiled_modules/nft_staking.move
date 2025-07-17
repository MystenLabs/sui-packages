module 0x8405bbfde348cfb58724288623ebdca677868d4e664021cbc66163015b2080f6::nft_staking {
    struct Treasury has key {
        id: 0x2::object::UID,
        status: bool,
    }

    struct NFT_STAKING has drop {
        dummy_field: bool,
    }

    public entry fun claim<T0: store + key>(arg0: &mut Treasury, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, 0x2::object::id<T0>(&arg1), arg1);
    }

    fun init(arg0: NFT_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id     : 0x2::object::new(arg1),
            status : true,
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun reclaim<T0: store + key>(arg0: &mut Treasury, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1), arg2);
    }

    // decompiled from Move bytecode v6
}

