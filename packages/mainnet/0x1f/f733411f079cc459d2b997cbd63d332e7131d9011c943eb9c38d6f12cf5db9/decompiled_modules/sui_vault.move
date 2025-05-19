module 0x1ff733411f079cc459d2b997cbd63d332e7131d9011c943eb9c38d6f12cf5db9::sui_vault {
    struct SuiVault has store, key {
        id: 0x2::object::UID,
        owner: address,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        deposit_locked: bool,
    }

    public entry fun create_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = SuiVault{
            id             : 0x2::object::new(arg1),
            owner          : v0,
            coin           : arg0,
            deposit_locked : false,
        };
        0x2::transfer::public_transfer<SuiVault>(v1, v0);
    }

    public fun get_balance(arg0: &SuiVault) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.coin)
    }

    public entry fun send_sui_to_vault(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut SuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1.deposit_locked) {
            abort 1
        };
        if (0x2::tx_context::sender(arg2) == arg1.owner) {
            abort 2
        };
        if (0x2::coin::value<0x2::sui::SUI>(arg0) < 4319421160000000000) {
            abort 2
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.coin, 0x2::coin::split<0x2::sui::SUI>(arg0, 4319421160000000000, arg2));
        arg1.deposit_locked = true;
    }

    public entry fun withdraw_from_vault(arg0: &mut SuiVault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg3) != arg0.owner) {
            abort 1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.coin, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

