module 0x53de4482b5c3d56361eede036dcb8211ee5a5ad7429f6a141b791cbcb7ed376::types {
    public(friend) fun BUFF_FORTUNE() : u8 {
        5
    }

    public(friend) fun BUFF_FROZEN() : u8 {
        2
    }

    public(friend) fun BUFF_LAND_BLESSING() : u8 {
        4
    }

    public(friend) fun BUFF_MOVE_CTRL() : u8 {
        1
    }

    public(friend) fun BUFF_NAVI_INCOME_BOOST() : u8 {
        200
    }

    public(friend) fun BUFF_RENT_FREE() : u8 {
        3
    }

    public(friend) fun BUFF_SCALLOP_INCOME_BOOST() : u8 {
        201
    }

    public(friend) fun BUILDING_COMMERCIAL() : u8 {
        23
    }

    public(friend) fun BUILDING_HOTEL() : u8 {
        24
    }

    public(friend) fun BUILDING_NONE() : u8 {
        0
    }

    public(friend) fun BUILDING_OIL() : u8 {
        22
    }

    public(friend) fun BUILDING_RESEARCH() : u8 {
        21
    }

    public(friend) fun BUILDING_TEMPLE() : u8 {
        20
    }

    public(friend) fun CARD_BARRIER() : u8 {
        1
    }

    public(friend) fun CARD_BOMB() : u8 {
        2
    }

    public(friend) fun CARD_CLEANSE() : u8 {
        6
    }

    public(friend) fun CARD_DOG() : u8 {
        5
    }

    public(friend) fun CARD_FREEZE() : u8 {
        4
    }

    public(friend) fun CARD_MOVE_CTRL() : u8 {
        0
    }

    public(friend) fun CARD_RENT_FREE() : u8 {
        3
    }

    public(friend) fun CARD_TURN() : u8 {
        7
    }

    public(friend) fun DECISION_BUY_PROPERTY() : u8 {
        1
    }

    public(friend) fun DECISION_NONE() : u8 {
        0
    }

    public(friend) fun DECISION_PAY_RENT() : u8 {
        3
    }

    public(friend) fun DECISION_UPGRADE_PROPERTY() : u8 {
        2
    }

    public(friend) fun DEFAULT_HOSPITAL_TURNS() : u8 {
        2
    }

    public(friend) fun DEFAULT_MAX_PLAYERS() : u8 {
        4
    }

    public(friend) fun LEVEL_0() : u8 {
        0
    }

    public(friend) fun LEVEL_1() : u8 {
        1
    }

    public(friend) fun LEVEL_2() : u8 {
        2
    }

    public(friend) fun LEVEL_3() : u8 {
        3
    }

    public(friend) fun LEVEL_4() : u8 {
        4
    }

    public(friend) fun NPC_BARRIER() : u8 {
        20
    }

    public(friend) fun NPC_BOMB() : u8 {
        21
    }

    public(friend) fun NPC_DOG() : u8 {
        22
    }

    public(friend) fun NPC_FORTUNE_GOD() : u8 {
        25
    }

    public(friend) fun NPC_LAND_GOD() : u8 {
        23
    }

    public(friend) fun NPC_POOR_GOD() : u8 {
        26
    }

    public(friend) fun NPC_WEALTH_GOD() : u8 {
        24
    }

    public(friend) fun SIZE_1X1() : u8 {
        1
    }

    public(friend) fun SIZE_2X2() : u8 {
        2
    }

    public(friend) fun SKIP_HOSPITAL() : u8 {
        2
    }

    public(friend) fun STATUS_ACTIVE() : u8 {
        1
    }

    public(friend) fun STATUS_ENDED() : u8 {
        2
    }

    public(friend) fun STATUS_READY() : u8 {
        0
    }

    public(friend) fun TILE_BONUS() : u8 {
        4
    }

    public(friend) fun TILE_CARD() : u8 {
        6
    }

    public(friend) fun TILE_CHANCE() : u8 {
        3
    }

    public(friend) fun TILE_EMPTY() : u8 {
        0
    }

    public(friend) fun TILE_FEE() : u8 {
        5
    }

    public(friend) fun TILE_HOSPITAL() : u8 {
        2
    }

    public(friend) fun TILE_LOTTERY() : u8 {
        1
    }

    public(friend) fun TILE_NEWS() : u8 {
        7
    }

    public(friend) fun is_large_building_type(arg0: u8) : bool {
        arg0 >= BUILDING_TEMPLE() && arg0 <= BUILDING_HOTEL()
    }

    // decompiled from Move bytecode v6
}

