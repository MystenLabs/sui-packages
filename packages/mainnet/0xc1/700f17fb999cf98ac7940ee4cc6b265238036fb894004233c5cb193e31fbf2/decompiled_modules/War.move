module 0xc1700f17fb999cf98ac7940ee4cc6b265238036fb894004233c5cb193e31fbf2::War {
    struct Battle has copy, drop {
        cohort_id: u64,
        result: u8,
        proof: u64,
    }

    struct Loss has copy, drop {
        side: u8,
        type_no: u64,
        count: u64,
        proof: u64,
    }

    struct Loot has copy, drop {
        ferra: u64,
        cyra: u64,
        suistra: u64,
        proof: u64,
    }

    public fun Captured(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = Loot{
            ferra   : arg0,
            cyra    : arg1,
            suistra : arg2,
            proof   : arg3,
        };
        0x2::event::emit<Loot>(v0);
    }

    public fun Clash(arg0: u64, arg1: u8, arg2: u64) {
        let v0 = Battle{
            cohort_id : arg0,
            result    : arg1,
            proof     : arg2,
        };
        0x2::event::emit<Battle>(v0);
    }

    public fun Units(arg0: u8, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = Loss{
            side    : arg0,
            type_no : arg1,
            count   : arg2,
            proof   : arg3,
        };
        0x2::event::emit<Loss>(v0);
    }

    // decompiled from Move bytecode v6
}

