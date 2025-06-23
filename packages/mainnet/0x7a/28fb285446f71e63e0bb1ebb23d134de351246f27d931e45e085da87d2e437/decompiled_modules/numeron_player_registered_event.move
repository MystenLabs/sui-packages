module 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_player_registered_event {
    struct PlayerRegisteredEvent has copy, drop {
        player: address,
        position: 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_position::Position,
    }

    public fun new(arg0: address, arg1: 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_position::Position) : PlayerRegisteredEvent {
        PlayerRegisteredEvent{
            player   : arg0,
            position : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

