module 0x63a466797c81218b705c27b0dafdd26cc16d57ed1127dc2bef36e40c9d99a908::adventure_pack_opener {
    struct AdventurePackOpened has copy, drop {
        pack_id: 0x2::object::ID,
        owner: address,
        equipment_type: u8,
        rarity: u8,
        experience_gained: u64,
    }

    fun calculate_experience_by_rarity(arg0: u8) : u64 {
        if (arg0 == 0) {
            10
        } else if (arg0 == 1) {
            25
        } else if (arg0 == 2) {
            50
        } else if (arg0 == 3) {
            100
        } else if (arg0 == 4) {
            250
        } else if (arg0 == 5) {
            500
        } else {
            10
        }
    }

    fun determine_equipment_type_and_rarity(arg0: u64) : (u8, u8) {
        let v0 = arg0 % 1000;
        let v1 = 0 + 500;
        if (v0 < v1) {
            return (0, 0)
        };
        let v2 = v1 + 250;
        if (v0 < v2) {
            return (1, 1)
        };
        let v3 = v2 + 100;
        if (v0 < v3) {
            return (2, 2)
        };
        let v4 = v3 + 50;
        if (v0 < v4) {
            return (3, 3)
        };
        let v5 = v4 + 10;
        if (v0 < v5) {
            return (4, 4)
        };
        if (v0 < v5 + 5) {
            return (5, 5)
        };
        (0, 0)
    }

    fun determine_equipment_type_and_rarity_by_pack(arg0: u64, arg1: u8) : (u8, u8) {
        if (arg1 == 0) {
            determine_equipment_type_explorer_pack(arg0)
        } else if (arg1 == 1) {
            determine_equipment_type_warrior_pack(arg0)
        } else {
            determine_equipment_type_and_rarity(arg0)
        }
    }

    fun determine_equipment_type_explorer_pack(arg0: u64) : (u8, u8) {
        let v0 = arg0 % 1000;
        let v1 = 0 + 588;
        if (v0 < v1) {
            return (0, 0)
        };
        if (v0 < v1 + 294) {
            return (1, 1)
        };
        (2, 2)
    }

    fun determine_equipment_type_warrior_pack(arg0: u64) : (u8, u8) {
        let v0 = arg0 % 1000;
        let v1 = 0 + 549;
        if (v0 < v1) {
            return (0, 0)
        };
        let v2 = v1 + 275;
        if (v0 < v2) {
            return (1, 1)
        };
        let v3 = v2 + 110;
        if (v0 < v3) {
            return (2, 2)
        };
        if (v0 < v3 + 55) {
            return (3, 3)
        };
        (4, 4)
    }

    public fun open_adventure_pack(arg0: 0x63a466797c81218b705c27b0dafdd26cc16d57ed1127dc2bef36e40c9d99a908::adventure_pack::AdventurePack, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x63a466797c81218b705c27b0dafdd26cc16d57ed1127dc2bef36e40c9d99a908::adventure_pack::AdventurePack>(&arg0);
        0x63a466797c81218b705c27b0dafdd26cc16d57ed1127dc2bef36e40c9d99a908::adventure_pack::burn(arg0);
        let (v1, v2) = determine_equipment_type_and_rarity_by_pack(0x2::clock::timestamp_ms(arg1) % 1000, 0x63a466797c81218b705c27b0dafdd26cc16d57ed1127dc2bef36e40c9d99a908::adventure_pack::pack_type(&arg0));
        let v3 = AdventurePackOpened{
            pack_id           : v0,
            owner             : 0x2::tx_context::sender(arg2),
            equipment_type    : v1,
            rarity            : v2,
            experience_gained : calculate_experience_by_rarity(v2),
        };
        0x2::event::emit<AdventurePackOpened>(v3);
        0x63a466797c81218b705c27b0dafdd26cc16d57ed1127dc2bef36e40c9d99a908::events::emit_adventure_pack_opened(v0, 0x2::tx_context::sender(arg2), 1);
    }

    // decompiled from Move bytecode v6
}

