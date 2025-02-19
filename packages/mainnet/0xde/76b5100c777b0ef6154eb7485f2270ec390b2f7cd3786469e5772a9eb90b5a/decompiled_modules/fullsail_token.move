module 0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::fullsail_token {
    public entry fun burn<T0>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::burn<T0>(arg0, arg1);
    }

    public entry fun mint<T0>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::mint<T0>(arg0, arg1, arg2, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

