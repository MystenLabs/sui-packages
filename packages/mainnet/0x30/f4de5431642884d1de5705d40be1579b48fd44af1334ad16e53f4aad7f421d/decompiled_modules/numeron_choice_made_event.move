module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_choice_made_event {
    struct ChoiceMadeEvent has copy, drop {
        player: address,
        player_choice: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_choice::Choice,
        contract_choice: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_choice::Choice,
        result: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_game_result::GameResult,
    }

    public fun new(arg0: address, arg1: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_choice::Choice, arg2: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_choice::Choice, arg3: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_game_result::GameResult) : ChoiceMadeEvent {
        ChoiceMadeEvent{
            player          : arg0,
            player_choice   : arg1,
            contract_choice : arg2,
            result          : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

