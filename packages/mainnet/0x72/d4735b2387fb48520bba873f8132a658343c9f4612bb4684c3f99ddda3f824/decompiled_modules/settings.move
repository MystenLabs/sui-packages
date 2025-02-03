module 0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::settings {
    struct Settings has key {
        id: 0x2::object::UID,
        price: u64,
        phase: u8,
        status: u8,
    }

    struct SettingsAdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Settings {
        Settings{
            id     : 0x2::object::new(arg0),
            price  : 0,
            phase  : 0,
            status : 0,
        }
    }

    public(friend) fun phase(arg0: &Settings) : u8 {
        arg0.phase
    }

    public(friend) fun price(arg0: &Settings) : u64 {
        arg0.price
    }

    public(friend) fun set_phase(arg0: &mut Settings, arg1: u8) {
        arg0.phase = arg1;
    }

    public(friend) fun set_price(arg0: &mut Settings, arg1: u64) {
        arg0.price = arg1;
    }

    public(friend) fun set_status(arg0: &mut Settings, arg1: u8) {
        arg0.status = arg1;
    }

    public(friend) fun status(arg0: &Settings) : u8 {
        arg0.status
    }

    public(friend) fun transfer_setting(arg0: Settings, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SettingsAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SettingsAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Settings>(arg0);
    }

    public(friend) fun uid_mut(arg0: &mut Settings) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

