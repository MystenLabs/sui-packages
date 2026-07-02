module 0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::controller_rental_receipt {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RentalReceipt has key {
        id: 0x2::object::UID,
        receipt_number: u64,
        renter: address,
        controller_model: 0x1::string::String,
        rental_days: u64,
        price_paid_mist: u64,
        start_epoch: u64,
        end_epoch: u64,
    }

    struct RentalCounter has key {
        id: 0x2::object::UID,
        total: u64,
    }

    public entry fun burn_receipt(arg0: &AdminCap, arg1: RentalReceipt) {
        let RentalReceipt {
            id               : v0,
            receipt_number   : _,
            renter           : _,
            controller_model : _,
            rental_days      : _,
            price_paid_mist  : _,
            start_epoch      : _,
            end_epoch        : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun end_epoch(arg0: &RentalReceipt) : u64 {
        arg0.end_epoch
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RentalCounter{
            id    : 0x2::object::new(arg0),
            total : 0,
        };
        0x2::transfer::share_object<RentalCounter>(v1);
    }

    public entry fun issue_receipt(arg0: &AdminCap, arg1: &mut RentalCounter, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        arg1.total = arg1.total + 1;
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = RentalReceipt{
            id               : 0x2::object::new(arg6),
            receipt_number   : arg1.total,
            renter           : arg2,
            controller_model : 0x1::string::utf8(arg3),
            rental_days      : arg4,
            price_paid_mist  : arg5,
            start_epoch      : v0,
            end_epoch        : v0 + arg4,
        };
        0x2::transfer::transfer<RentalReceipt>(v1, arg2);
    }

    public fun rental_days(arg0: &RentalReceipt) : u64 {
        arg0.rental_days
    }

    public fun renter(arg0: &RentalReceipt) : address {
        arg0.renter
    }

    public fun treasury() : address {
        @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0
    }

    // decompiled from Move bytecode v7
}

