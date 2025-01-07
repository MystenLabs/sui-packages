module 0x1c950beb919eaa83e1ad82df28ed2310c20ea77b426fd7c68e531c28e1a26564::ocean_seafood {
    struct App has key {
        id: 0x2::object::UID,
        payment_address: address,
        seafoods: 0x2::table_vec::TableVec<Seafood>,
        version: u8,
    }

    struct Seafood has store {
        level: u8,
        price: u64,
        enable: bool,
    }

    struct UpgradeSeafood has copy, drop, store {
        caller: address,
        level: u8,
        price: u64,
    }

    struct SeafoodOwnerCap has key {
        id: 0x2::object::UID,
    }

    public fun authorize_game(arg0: &0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::OwnerCap, arg1: &mut App) {
        0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::authorize_app(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = App{
            id              : 0x2::object::new(arg0),
            payment_address : @0x91d68bc6841da3efa549deace2d08413555c441d72d21d3d4a1a65b32e08fd02,
            seafoods        : 0x2::table_vec::empty<Seafood>(arg0),
            version         : 1,
        };
        0x2::transfer::share_object<App>(v0);
        let v1 = SeafoodOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SeafoodOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &SeafoodOwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 6);
        arg1.version = 1;
    }

    entry fun update_payment_address(arg0: &SeafoodOwnerCap, arg1: &mut App, arg2: address) {
        arg1.payment_address = arg2;
    }

    entry fun update_seafoods(arg0: &SeafoodOwnerCap, arg1: &mut App, arg2: vector<u64>, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<bool>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u8>(&arg3) && v0 == 0x1::vector::length<u64>(&arg4) && v0 == 0x1::vector::length<bool>(&arg5), 2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            if (v2 < 0x2::table_vec::length<Seafood>(&arg1.seafoods)) {
                let v3 = 0x2::table_vec::borrow_mut<Seafood>(&mut arg1.seafoods, v2);
                v3.level = *0x1::vector::borrow<u8>(&arg3, v1);
                v3.price = *0x1::vector::borrow<u64>(&arg4, v1);
                v3.enable = *0x1::vector::borrow<bool>(&arg5, v1);
            } else {
                let v4 = Seafood{
                    level  : *0x1::vector::borrow<u8>(&arg3, v1),
                    price  : *0x1::vector::borrow<u64>(&arg4, v1),
                    enable : *0x1::vector::borrow<bool>(&arg5, v1),
                };
                0x2::table_vec::push_back<Seafood>(&mut arg1.seafoods, v4);
            };
            v1 = v1 + 1;
        };
    }

    entry fun upgrade_seafood(arg0: &mut App, arg1: &mut 0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::GameInfo, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game::auth_upgrade_seafood(&mut arg0.id, arg1, 1, v0);
        assert!((v1 as u64) < 0x2::table_vec::length<Seafood>(&arg0.seafoods), 7);
        let v2 = 0x2::table_vec::borrow_mut<Seafood>(&mut arg0.seafoods, (v1 as u64));
        assert!(v2.enable, 3);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v4 = v2.price;
        assert!(v3 >= v4, 4);
        let v5 = if (v3 > v4) {
            0x2::pay::keep<0x2::sui::SUI>(arg2, arg3);
            0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg3)
        } else {
            arg2
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, arg0.payment_address);
        let v6 = UpgradeSeafood{
            caller : v0,
            level  : v1,
            price  : v4,
        };
        0x2::event::emit<UpgradeSeafood>(v6);
    }

    // decompiled from Move bytecode v6
}

