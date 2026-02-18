module 0x33bd2f7e8b9032625fb2647bc840eeed71e4c2e7fa8a3f2b65d869a2472fc710::rwa_nft {
    struct RWANFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        amount: 0x1::string::String,
        currency: 0x1::string::String,
        due_date: 0x1::string::String,
        issuer: 0x1::string::String,
        status: 0x1::string::String,
    }

    struct RWAMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        status: 0x1::string::String,
    }

    struct RWAStatusUpdated has copy, drop {
        object_id: 0x2::object::ID,
        old_status: 0x1::string::String,
        new_status: 0x1::string::String,
    }

    struct RWABurned has copy, drop {
        object_id: 0x2::object::ID,
        details: 0x1::string::String,
    }

    public fun url(arg0: &RWANFT) : 0x2::url::Url {
        arg0.url
    }

    public fun amount(arg0: &RWANFT) : 0x1::string::String {
        arg0.amount
    }

    public fun burn(arg0: RWANFT, arg1: &mut 0x2::tx_context::TxContext) {
        let RWANFT {
            id          : v0,
            name        : v1,
            description : _,
            url         : _,
            amount      : _,
            currency    : _,
            due_date    : _,
            issuer      : _,
            status      : _,
        } = arg0;
        let v9 = v0;
        let v10 = RWABurned{
            object_id : 0x2::object::uid_to_inner(&v9),
            details   : v1,
        };
        0x2::event::emit<RWABurned>(v10);
        0x2::object::delete(v9);
    }

    public fun currency(arg0: &RWANFT) : 0x1::string::String {
        arg0.currency
    }

    public fun description(arg0: &RWANFT) : 0x1::string::String {
        arg0.description
    }

    public fun due_date(arg0: &RWANFT) : 0x1::string::String {
        arg0.due_date
    }

    public fun issuer(arg0: &RWANFT) : 0x1::string::String {
        arg0.issuer
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = RWANFT{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            amount      : 0x1::string::utf8(arg3),
            currency    : 0x1::string::utf8(arg4),
            due_date    : 0x1::string::utf8(arg5),
            issuer      : 0x1::string::utf8(arg6),
            status      : 0x1::string::utf8(b"Pending"),
        };
        let v2 = RWAMinted{
            object_id : 0x2::object::id<RWANFT>(&v1),
            creator   : v0,
            name      : v1.name,
            status    : v1.status,
        };
        0x2::event::emit<RWAMinted>(v2);
        0x2::transfer::public_transfer<RWANFT>(v1, v0);
    }

    public fun name(arg0: &RWANFT) : 0x1::string::String {
        arg0.name
    }

    public fun status(arg0: &RWANFT) : 0x1::string::String {
        arg0.status
    }

    public fun update_status(arg0: &mut RWANFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.status = 0x1::string::utf8(arg1);
        let v0 = RWAStatusUpdated{
            object_id  : 0x2::object::id<RWANFT>(arg0),
            old_status : arg0.status,
            new_status : arg0.status,
        };
        0x2::event::emit<RWAStatusUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

