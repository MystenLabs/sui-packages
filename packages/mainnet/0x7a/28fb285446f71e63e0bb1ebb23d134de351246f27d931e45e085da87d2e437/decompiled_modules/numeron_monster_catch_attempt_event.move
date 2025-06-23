module 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_catch_attempt_event {
    struct MonsterCatchAttemptEvent has copy, drop {
        player: address,
        monster_id: u256,
        result: 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_catch_result::MonsterCatchResult,
    }

    public fun new(arg0: address, arg1: u256, arg2: 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_catch_result::MonsterCatchResult) : MonsterCatchAttemptEvent {
        MonsterCatchAttemptEvent{
            player     : arg0,
            monster_id : arg1,
            result     : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

