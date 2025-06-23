module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_player_registered_event {
    struct PlayerRegisteredEvent has copy, drop {
        player: address,
        position: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position,
    }

    public fun new(arg0: address, arg1: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position) : PlayerRegisteredEvent {
        PlayerRegisteredEvent{
            player   : arg0,
            position : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

