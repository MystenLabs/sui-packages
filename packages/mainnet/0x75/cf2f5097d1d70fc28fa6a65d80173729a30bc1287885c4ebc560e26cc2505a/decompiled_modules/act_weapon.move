module 0x75cf2f5097d1d70fc28fa6a65d80173729a30bc1287885c4ebc560e26cc2505a::act_weapon {
    struct ACT_WEAPON has drop {
        dummy_field: bool,
    }

    struct Minter has store, key {
        id: 0x2::object::UID,
    }

    struct Weapon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        edition: 0x1::string::String,
        wear_rating: u64,
        rarity: 0x1::string::String,
        colourway: 0x1::string::String,
        manufacturer: 0x1::string::String,
        slot: 0x1::string::String,
        creator: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: ACT_WEAPON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Minter{id: 0x2::object::new(arg1)};
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x2::package::claim<ACT_WEAPON>(arg0, arg1);
        0x2::transfer::public_transfer<Minter>(v0, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, v1);
        0x2::transfer::public_transfer<0x2::display::Display<Weapon>>(0x2::display::new<Weapon>(&v2, arg1), v1);
    }

    public fun mint(arg0: &Minter, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) : Weapon {
        Weapon{
            id           : 0x2::object::new(arg11),
            name         : arg1,
            edition      : arg2,
            wear_rating  : arg3,
            rarity       : arg4,
            colourway    : arg5,
            manufacturer : arg6,
            slot         : arg7,
            creator      : arg8,
            description  : arg9,
            image_url    : arg10,
        }
    }

    // decompiled from Move bytecode v6
}

