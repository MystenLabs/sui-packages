module 0xe8364c20ed22e57e9d9549d8316b6efe13e7927cbc25d92a938c1a5fac09d3ea::main {
    entry fun recover_funds<T0>(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), arg1), arg2);
    }

    // decompiled from Move bytecode v6
}

