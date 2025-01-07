module 0xc3fefe6818f438ea24c5f1fc2268a52354fceabf372d5170bc9494cf96f553ca::xdd_object_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        xdd_object: 0x2::balance::Balance<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>,
        xdd_object_faucet: 0x2::balance::Balance<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>,
    }

    public entry fun faucet_to_xdd_object(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&arg1) / 2;
        assert!(0x2::balance::value<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(&arg0.xdd_object) >= v0, 65538);
        0x2::balance::join<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&mut arg0.xdd_object_faucet, 0x2::coin::into_balance<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>>(0x2::coin::from_balance<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(0x2::balance::split<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(&mut arg0.xdd_object, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun get_xdd_object_balance(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>>(0x2::coin::from_balance<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(0x2::balance::split<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(&mut arg1.xdd_object, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun get_xdd_object_faucet_balance(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>>(0x2::coin::from_balance<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(0x2::balance::split<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&mut arg1.xdd_object_faucet, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Bank{
            id                : 0x2::object::new(arg0),
            xdd_object        : 0x2::balance::zero<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(),
            xdd_object_faucet : 0x2::balance::zero<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(),
        };
        0x2::transfer::share_object<Bank>(v1);
    }

    public entry fun save_xdd_object_balance(arg0: &AdminCap, arg1: &mut Bank, arg2: 0x2::coin::Coin<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(&mut arg1.xdd_object, 0x2::coin::into_balance<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(arg2));
    }

    public entry fun save_xdd_object_faucet_balance(arg0: &AdminCap, arg1: &mut Bank, arg2: 0x2::coin::Coin<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&mut arg1.xdd_object_faucet, 0x2::coin::into_balance<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(arg2));
    }

    public entry fun xdd_object_to_faucet(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(&arg1) * 2;
        assert!(0x2::balance::value<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&arg0.xdd_object_faucet) >= v0, 65538);
        0x2::balance::join<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(&mut arg0.xdd_object, 0x2::coin::into_balance<0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object::XDD_OBJECT>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>>(0x2::coin::from_balance<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(0x2::balance::split<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&mut arg0.xdd_object_faucet, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

