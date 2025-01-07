module 0x35d681500cb35c2c4839622ad3f4bee497498d296b52ca6ee89c004fde57545b::my_game {
    struct PhigrosX_Sword has store, key {
        id: 0x2::object::UID,
        material: u8,
    }

    public entry fun buySword(arg0: 0x2::token::Token<0x35d681500cb35c2c4839622ad3f4bee497498d296b52ca6ee89c004fde57545b::PhigrosX::PHIGROSX>, arg1: &0x2::random::Random, arg2: &mut 0x2::coin::TreasuryCap<0x35d681500cb35c2c4839622ad3f4bee497498d296b52ca6ee89c004fde57545b::PhigrosX::PHIGROSX>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::token::value<0x35d681500cb35c2c4839622ad3f4bee497498d296b52ca6ee89c004fde57545b::PhigrosX::PHIGROSX>(&arg0) == 20, 111);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100);
        if (v1 < 10) {
            let v2 = PhigrosX_Sword{
                id       : 0x2::object::new(arg3),
                material : 1,
            };
            0x2::transfer::public_transfer<PhigrosX_Sword>(v2, 0x2::tx_context::sender(arg3));
        } else if (v1 >= 10 && v1 < 30) {
            let v3 = PhigrosX_Sword{
                id       : 0x2::object::new(arg3),
                material : 2,
            };
            0x2::transfer::public_transfer<PhigrosX_Sword>(v3, 0x2::tx_context::sender(arg3));
        } else {
            let v4 = PhigrosX_Sword{
                id       : 0x2::object::new(arg3),
                material : 3,
            };
            0x2::transfer::public_transfer<PhigrosX_Sword>(v4, 0x2::tx_context::sender(arg3));
        };
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<0x35d681500cb35c2c4839622ad3f4bee497498d296b52ca6ee89c004fde57545b::PhigrosX::PHIGROSX>(arg2, 0x2::token::spend<0x35d681500cb35c2c4839622ad3f4bee497498d296b52ca6ee89c004fde57545b::PhigrosX::PHIGROSX>(arg0, arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

