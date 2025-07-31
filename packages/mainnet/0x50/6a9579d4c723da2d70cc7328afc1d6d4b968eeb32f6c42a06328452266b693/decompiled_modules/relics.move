module 0x506a9579d4c723da2d70cc7328afc1d6d4b968eeb32f6c42a06328452266b693::relics {
    struct RELICS has drop {
        dummy_field: bool,
    }

    struct Relic has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
        item_type: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: Relic) {
        let Relic {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            item_type   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: RELICS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<RELICS>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Relic{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            rarity      : arg4,
            item_type   : arg5,
        };
        0x2::transfer::public_transfer<Relic>(v0, arg6);
    }

    // decompiled from Move bytecode v6
}

