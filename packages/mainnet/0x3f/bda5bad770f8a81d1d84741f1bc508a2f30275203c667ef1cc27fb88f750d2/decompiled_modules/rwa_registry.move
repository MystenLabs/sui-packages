module 0x3fbda5bad770f8a81d1d84741f1bc508a2f30275203c667ef1cc27fb88f750d2::rwa_registry {
    struct RWANFT has store, key {
        id: 0x2::object::UID,
        asset_type: u8,
        name: 0x1::string::String,
        location: 0x1::string::String,
        valuation: u64,
        documentation_uri: 0x1::string::String,
        issuer: address,
        status: u8,
        created_at: u64,
    }

    struct RWAMinted has copy, drop {
        token_id: address,
        asset_type: u8,
        name: 0x1::string::String,
        valuation: u64,
        issuer: address,
    }

    struct RWAStatusUpdated has copy, drop {
        token_id: address,
        old_status: u8,
        new_status: u8,
    }

    struct RWABurned has copy, drop {
        token_id: address,
        name: 0x1::string::String,
    }

    public entry fun burn(arg0: RWANFT, arg1: &mut 0x2::tx_context::TxContext) {
        let RWANFT {
            id                : v0,
            asset_type        : _,
            name              : v2,
            location          : _,
            valuation         : _,
            documentation_uri : _,
            issuer            : _,
            status            : _,
            created_at        : _,
        } = arg0;
        let v9 = v0;
        let v10 = RWABurned{
            token_id : 0x2::object::uid_to_address(&v9),
            name     : v2,
        };
        0x2::event::emit<RWABurned>(v10);
        0x2::object::delete(v9);
    }

    public fun get_asset_type(arg0: &RWANFT) : u8 {
        arg0.asset_type
    }

    public fun get_status(arg0: &RWANFT) : u8 {
        arg0.status
    }

    public fun get_valuation(arg0: &RWANFT) : u64 {
        arg0.valuation
    }

    public entry fun mint_bond(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        mint_rwa(3, arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun mint_invoice(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        mint_rwa(2, arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun mint_real_estate(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        mint_rwa(1, arg0, arg1, arg2, arg3, arg4);
    }

    fun mint_rwa(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 >= 1 && arg0 <= 3, 0);
        assert!(arg3 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = RWANFT{
            id                : 0x2::object::new(arg5),
            asset_type        : arg0,
            name              : 0x1::string::utf8(arg1),
            location          : 0x1::string::utf8(arg2),
            valuation         : arg3,
            documentation_uri : 0x1::string::utf8(arg4),
            issuer            : v0,
            status            : 1,
            created_at        : 0x2::tx_context::epoch(arg5),
        };
        let v2 = RWAMinted{
            token_id   : 0x2::object::uid_to_address(&v1.id),
            asset_type : arg0,
            name       : v1.name,
            valuation  : arg3,
            issuer     : v0,
        };
        0x2::event::emit<RWAMinted>(v2);
        0x2::transfer::public_transfer<RWANFT>(v1, v0);
    }

    public entry fun transfer_rwa(arg0: RWANFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<RWANFT>(arg0, arg1);
    }

    public entry fun update_status(arg0: &mut RWANFT, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.issuer, 2);
        arg0.status = arg1;
        let v0 = RWAStatusUpdated{
            token_id   : 0x2::object::uid_to_address(&arg0.id),
            old_status : arg0.status,
            new_status : arg1,
        };
        0x2::event::emit<RWAStatusUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

