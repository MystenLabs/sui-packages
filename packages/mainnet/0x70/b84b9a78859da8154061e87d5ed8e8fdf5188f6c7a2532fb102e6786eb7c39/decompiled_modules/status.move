module 0x70b84b9a78859da8154061e87d5ed8e8fdf5188f6c7a2532fb102e6786eb7c39::status {
    struct Status has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        class: u64,
        level: u64,
        exp: u64,
        stats: Stats,
        talent: Talent,
        battle_log: BattleLog,
        padding: vector<u64>,
    }

    struct BattleLog has drop, store {
        win: u64,
        lose: u64,
        quit: u64,
        dealed_damage: u64,
        kill: u64,
        dead: u64,
        asist: u64,
    }

    struct Stats has drop, store {
        health: u64,
        attack_damage: u64,
        ablity_power: u64,
        armor: u64,
        magic_resist: u64,
        speed: u64,
        padding: vector<u64>,
    }

    struct Talent has drop, store {
        health: u64,
        attack_damage: u64,
        ablity_power: u64,
        armor: u64,
        magic_resist: u64,
        speed: u64,
        padding: vector<u64>,
    }

    public fun install_status_frens<T0>(arg0: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(*0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::genes<T0>(arg0));
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        let v2 = 0x2::bcs::peel_u8(&mut v0);
        let v3 = 0x2::bcs::peel_u8(&mut v0);
        let v4 = 0x2::bcs::peel_u8(&mut v0);
        let v5 = 0x2::bcs::peel_u8(&mut v0);
        let v6 = 0x2::bcs::peel_u8(&mut v0);
        let v7 = Stats{
            health        : ((v1 % 100) as u64),
            attack_damage : ((v2 % 100) as u64),
            ablity_power  : ((v3 % 100) as u64),
            armor         : ((v4 % 100) as u64),
            magic_resist  : ((v5 % 100) as u64),
            speed         : ((v6 % 100) as u64),
            padding       : 0x1::vector::empty<u64>(),
        };
        let v8 = Talent{
            health        : ((v1 % 100 / 10) as u64),
            attack_damage : ((v2 % 100 / 10) as u64),
            ablity_power  : ((v3 % 100 / 10) as u64),
            armor         : ((v4 % 100 / 10) as u64),
            magic_resist  : ((v5 % 100 / 10) as u64),
            speed         : ((v6 % 100 / 10) as u64),
            padding       : 0x1::vector::empty<u64>(),
        };
        let v9 = BattleLog{
            win           : 0,
            lose          : 0,
            quit          : 0,
            dealed_damage : 0,
            kill          : 0,
            dead          : 0,
            asist         : 0,
        };
        let v10 = Status{
            id         : 0x2::object::new(arg2),
            name       : arg1,
            class      : 0,
            level      : 1,
            exp        : 0,
            stats      : v7,
            talent     : v8,
            battle_log : v9,
            padding    : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_field::add<0x1::string::String, Status>(0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg0), 0x1::string::utf8(b"battle_status"), v10);
    }

    // decompiled from Move bytecode v6
}

