module 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_choice_made_event {
    struct ChoiceMadeEvent has copy, drop {
        player: address,
        player_choice: 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_choice::Choice,
        contract_choice: 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_choice::Choice,
        result: 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_game_result::GameResult,
    }

    public fun new(arg0: address, arg1: 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_choice::Choice, arg2: 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_choice::Choice, arg3: 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_game_result::GameResult) : ChoiceMadeEvent {
        ChoiceMadeEvent{
            player          : arg0,
            player_choice   : arg1,
            contract_choice : arg2,
            result          : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

