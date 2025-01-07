module 0xece8bb012c7646b84ccb2eac17a293eab4aca5d20e6bd168972327373b836a20::dev_pass {
    struct Subscription<phantom T0> has key {
        id: 0x2::object::UID,
        uses: u64,
    }

    struct SingleUse<phantom T0> {
        dummy_field: bool,
    }

    public fun transfer<T0: drop>(arg0: T0, arg1: Subscription<T0>, arg2: address) {
        0x2::transfer::transfer<Subscription<T0>>(arg1, arg2);
    }

    public fun add_uses<T0: drop>(arg0: T0, arg1: &mut Subscription<T0>, arg2: u64) {
        arg1.uses = arg1.uses + arg2;
    }

    public fun confirm_use<T0: drop>(arg0: T0, arg1: SingleUse<T0>) {
        let SingleUse {  } = arg1;
    }

    public entry fun destroy<T0>(arg0: Subscription<T0>) {
        let Subscription {
            id   : v0,
            uses : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun issue_subscription<T0: drop>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Subscription<T0> {
        Subscription<T0>{
            id   : 0x2::object::new(arg2),
            uses : arg1,
        }
    }

    public fun use_pass<T0>(arg0: &mut Subscription<T0>) : SingleUse<T0> {
        assert!(arg0.uses != 0, 0);
        arg0.uses = arg0.uses - 1;
        SingleUse<T0>{dummy_field: false}
    }

    public fun uses<T0>(arg0: &Subscription<T0>) : u64 {
        arg0.uses
    }

    // decompiled from Move bytecode v6
}

