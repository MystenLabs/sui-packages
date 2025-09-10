module 0x5dca1179b6419a3334fc320179cccf78b47f96310ab43058972ac6b86fa2bbe7::act_weapon {
    struct ACT_WEAPON has drop {
        dummy_field: bool,
    }

    struct Minter has store, key {
        id: 0x2::object::UID,
    }

    struct Weapon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        wear_rating: u64,
        rarity: 0x1::string::String,
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

    public fun mint(arg0: &Minter, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Weapon {
        Weapon{
            id           : 0x2::object::new(arg9),
            name         : arg1,
            wear_rating  : arg2,
            rarity       : arg3,
            manufacturer : arg4,
            slot         : arg5,
            creator      : arg6,
            description  : arg7,
            image_url    : arg8,
        }
    }

    // decompiled from Move bytecode v6
}

