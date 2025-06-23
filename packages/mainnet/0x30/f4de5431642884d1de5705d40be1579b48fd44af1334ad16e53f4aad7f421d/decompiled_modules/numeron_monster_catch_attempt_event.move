module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_catch_attempt_event {
    struct MonsterCatchAttemptEvent has copy, drop {
        player: address,
        monster_id: u256,
        result: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_catch_result::MonsterCatchResult,
    }

    public fun new(arg0: address, arg1: u256, arg2: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_catch_result::MonsterCatchResult) : MonsterCatchAttemptEvent {
        MonsterCatchAttemptEvent{
            player     : arg0,
            monster_id : arg1,
            result     : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

