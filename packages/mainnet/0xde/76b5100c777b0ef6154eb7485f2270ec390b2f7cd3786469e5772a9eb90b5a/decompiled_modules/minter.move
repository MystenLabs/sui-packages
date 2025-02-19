module 0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::minter {
    public entry fun set_minter_cap<T0>(arg0: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::AdminCap, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::Minter<T0>, arg2: 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::set_minter_cap<T0>(arg1, arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

