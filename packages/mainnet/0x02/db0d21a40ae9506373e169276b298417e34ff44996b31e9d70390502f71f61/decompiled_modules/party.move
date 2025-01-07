module 0x2db0d21a40ae9506373e169276b298417e34ff44996b31e9d70390502f71f61::party {
    struct Balloon has key {
        id: 0x2::object::UID,
        popped: bool,
    }

    public entry fun fill_up_balloon(arg0: &mut 0x2::tx_context::TxContext) {
        new_balloon(arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_balloon(arg0);
    }

    fun new_balloon(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Balloon{
            id     : 0x2::object::new(arg0),
            popped : false,
        };
        0x2::transfer::share_object<Balloon>(v0);
    }

    public entry fun pop_balloon(arg0: &mut Balloon) {
        arg0.popped = true;
    }

    public entry fun throw_away_balloon(arg0: Balloon) {
        let Balloon {
            id     : v0,
            popped : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

