module 0x1ec8d31495d77b02df858458b604489a79ed10927b8898e5454147d3b3cdec5b::my_game {
    struct PhigrosX_Sword has store, key {
        id: 0x2::object::UID,
        material: u8,
    }

    public entry fun buySword(arg0: 0x2::token::Token<0x1ec8d31495d77b02df858458b604489a79ed10927b8898e5454147d3b3cdec5b::PhigrosX::PHIGROSX>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::TreasuryCap<0x1ec8d31495d77b02df858458b604489a79ed10927b8898e5454147d3b3cdec5b::PhigrosX::PHIGROSX>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::token::value<0x1ec8d31495d77b02df858458b604489a79ed10927b8898e5454147d3b3cdec5b::PhigrosX::PHIGROSX>(&arg0) == 20, 111);
        let v0 = 0x2::clock::timestamp_ms(arg1) % 9;
        if (v0 == 0) {
            let v1 = PhigrosX_Sword{
                id       : 0x2::object::new(arg3),
                material : 1,
            };
            0x2::transfer::public_transfer<PhigrosX_Sword>(v1, 0x2::tx_context::sender(arg3));
        } else if (v0 >= 1 && v0 < 4) {
            let v2 = PhigrosX_Sword{
                id       : 0x2::object::new(arg3),
                material : 2,
            };
            0x2::transfer::public_transfer<PhigrosX_Sword>(v2, 0x2::tx_context::sender(arg3));
        } else {
            let v3 = PhigrosX_Sword{
                id       : 0x2::object::new(arg3),
                material : 3,
            };
            0x2::transfer::public_transfer<PhigrosX_Sword>(v3, 0x2::tx_context::sender(arg3));
        };
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<0x1ec8d31495d77b02df858458b604489a79ed10927b8898e5454147d3b3cdec5b::PhigrosX::PHIGROSX>(arg2, 0x2::token::spend<0x1ec8d31495d77b02df858458b604489a79ed10927b8898e5454147d3b3cdec5b::PhigrosX::PHIGROSX>(arg0, arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

