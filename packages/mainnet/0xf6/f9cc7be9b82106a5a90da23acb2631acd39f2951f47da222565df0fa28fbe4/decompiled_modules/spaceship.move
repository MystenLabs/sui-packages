module 0xf6f9cc7be9b82106a5a90da23acb2631acd39f2951f47da222565df0fa28fbe4::spaceship {
    struct Spaceship has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        hull: u64,
        laser: u64,
        shield: u64,
        rarity: u8,
        wins: u64,
        matches: u64,
    }

    struct ShipMinted has copy, drop {
        ship_id: address,
        owner: address,
        name: 0x1::string::String,
        rarity: u8,
    }

    struct ShipUpgraded has copy, drop {
        ship_id: address,
        stat: 0x1::string::String,
        new_value: u64,
    }

    public fun get_hull(arg0: &Spaceship) : u64 {
        arg0.hull
    }

    public fun get_laser(arg0: &Spaceship) : u64 {
        arg0.laser
    }

    public fun get_matches(arg0: &Spaceship) : u64 {
        arg0.matches
    }

    public fun get_rarity(arg0: &Spaceship) : u8 {
        arg0.rarity
    }

    public fun get_shield(arg0: &Spaceship) : u64 {
        arg0.shield
    }

    public fun get_wins(arg0: &Spaceship) : u64 {
        arg0.wins
    }

    public entry fun mint(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Spaceship{
            id      : 0x2::object::new(arg1),
            name    : 0x1::string::utf8(arg0),
            hull    : 100,
            laser   : 20,
            shield  : 30,
            rarity  : 1,
            wins    : 0,
            matches : 0,
        };
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = ShipMinted{
            ship_id : 0x2::object::uid_to_address(&v0.id),
            owner   : v1,
            name    : v0.name,
            rarity  : v0.rarity,
        };
        0x2::event::emit<ShipMinted>(v2);
        0x2::transfer::public_transfer<Spaceship>(v0, v1);
    }

    public(friend) fun record_match(arg0: &mut Spaceship, arg1: bool) {
        arg0.matches = arg0.matches + 1;
        if (arg1) {
            arg0.wins = arg0.wins + 1;
        };
    }

    public entry fun upgrade_hull(arg0: &mut Spaceship, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 30, 1);
        arg0.hull = arg0.hull + arg1;
        let v0 = ShipUpgraded{
            ship_id   : 0x2::object::uid_to_address(&arg0.id),
            stat      : 0x1::string::utf8(b"hull"),
            new_value : arg0.hull,
        };
        0x2::event::emit<ShipUpgraded>(v0);
    }

    public entry fun upgrade_laser(arg0: &mut Spaceship, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 20, 1);
        arg0.laser = arg0.laser + arg1;
        let v0 = ShipUpgraded{
            ship_id   : 0x2::object::uid_to_address(&arg0.id),
            stat      : 0x1::string::utf8(b"laser"),
            new_value : arg0.laser,
        };
        0x2::event::emit<ShipUpgraded>(v0);
    }

    public entry fun upgrade_shield(arg0: &mut Spaceship, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 20, 1);
        arg0.shield = arg0.shield + arg1;
        let v0 = ShipUpgraded{
            ship_id   : 0x2::object::uid_to_address(&arg0.id),
            stat      : 0x1::string::utf8(b"shield"),
            new_value : arg0.shield,
        };
        0x2::event::emit<ShipUpgraded>(v0);
    }

    // decompiled from Move bytecode v6
}

