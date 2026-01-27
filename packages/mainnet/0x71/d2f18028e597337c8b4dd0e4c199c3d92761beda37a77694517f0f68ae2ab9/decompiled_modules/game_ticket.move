module 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::game_ticket {
    struct GameTicket has key {
        id: 0x2::object::UID,
        next_season: u8,
    }

    struct NewAction {
        ticket_id: 0x2::object::ID,
        season: u8,
    }

    fun err_already_operated() {
        abort 0
    }

    public fun new_action(arg0: &GameTicket, arg1: &0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::config::Config) : NewAction {
        if (arg0.next_season > 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::config::current_season(arg1)) {
            err_already_operated();
        };
        NewAction{
            ticket_id : *0x2::object::uid_as_inner(&arg0.id),
            season    : 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::config::current_season(arg1),
        }
    }

    public fun new_action_season(arg0: &NewAction) : u8 {
        arg0.season
    }

    public fun new_action_ticket_id(arg0: &NewAction) : 0x2::object::ID {
        arg0.ticket_id
    }

    public fun new_game_ticket(arg0: &mut 0x2::tx_context::TxContext) : GameTicket {
        GameTicket{
            id          : 0x2::object::new(arg0),
            next_season : 0,
        }
    }

    public fun next_season(arg0: &GameTicket) : u8 {
        arg0.next_season
    }

    public fun remove_action(arg0: &mut GameTicket, arg1: NewAction) {
        let NewAction {
            ticket_id : _,
            season    : v1,
        } = arg1;
        arg0.next_season = v1 + 1;
    }

    public fun transfer_game_ticket(arg0: GameTicket, arg1: address) {
        0x2::transfer::transfer<GameTicket>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

