module 0x904a20c461e6893503e2732267b717fba937353ef5e6dc921d88e89a90967b7::gm {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GmTracker has store, key {
        id: 0x2::object::UID,
        gms: 0x2::object_table::ObjectTable<0x1::string::String, Gm>,
        epoch_start_timestamp: u64,
    }

    struct Gm has store, key {
        id: 0x2::object::UID,
        sender: address,
        message: 0x1::string::String,
        timestamp: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GmTracker{
            id                    : 0x2::object::new(arg0),
            gms                   : 0x2::object_table::new<0x1::string::String, Gm>(arg0),
            epoch_start_timestamp : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<GmTracker>(v1);
    }

    public fun new_gm(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &mut GmTracker, arg4: &mut 0x904a20c461e6893503e2732267b717fba937353ef5e6dc921d88e89a90967b7::gm_coin::TreasuryCapHolder, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Gm{
            id        : 0x2::object::new(arg5),
            sender    : 0x2::tx_context::sender(arg5),
            message   : arg1,
            timestamp : arg2,
        };
        0x2::object_table::add<0x1::string::String, Gm>(&mut arg3.gms, arg0, v0);
        0x904a20c461e6893503e2732267b717fba937353ef5e6dc921d88e89a90967b7::gm_coin::mint_one(arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

