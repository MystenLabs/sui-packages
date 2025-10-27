module 0xfd5d94af944d1384a2f7dbda84c4480509c5ddab99b1b9fec1f2768ae7baaa3c::eraser {
    struct ERASER has drop {
        dummy_field: bool,
    }

    struct PfpNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        is_revealed: bool,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        number: u64,
        url: 0x1::string::String,
    }

    struct CaptainAttributes has copy, drop, store {
        headgear: 0x1::string::String,
        horizon: 0x1::string::String,
        armament: 0x1::string::String,
        companion: 0x1::string::String,
        physical: 0x1::string::String,
        whiskers: 0x1::string::String,
    }

    struct CaptainRevealed has store, key {
        id: 0x2::object::UID,
        captain_id: u64,
        attributes: CaptainAttributes,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct Payout has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct MintConfig has store, key {
        id: 0x2::object::UID,
        mint_price: u64,
        max_supply: u64,
        current_supply: u64,
        is_paused: bool,
        per_address_limit: u64,
        per_stage_limit: u64,
        default_stage_limit: u64,
        payout_address: address,
        pubkey_bytes: vector<u8>,
        pubkey_set: 0x2::vec_set::VecSet<address>,
    }

    struct MintStats has store, key {
        id: 0x2::object::UID,
        per_address: 0x2::table::Table<address, u64>,
        per_stage: 0x2::table::Table<u64, u64>,
        per_stage_limits: 0x2::table::Table<u64, u64>,
    }

    struct TraitsRegistry has store, key {
        id: 0x2::object::UID,
        traits: 0x2::table::Table<0x1::string::String, 0x2::table::Table<0x1::string::String, u64>>,
    }

    struct PubKey has store, key {
        id: 0x2::object::UID,
        pubkey_bytes: vector<u8>,
        pubkey_set: 0x2::vec_set::VecSet<address>,
    }

    public fun admin_delete_display(arg0: 0x2::display::Display<PfpNFT>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5, 0);
        abort 0
    }

    public fun admin_delete_transfer_policy(arg0: 0x2::transfer_policy::TransferPolicy<PfpNFT>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5, 0);
        abort 0
    }

    public fun delete_object_by_uid(arg0: 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5, 0);
        0x2::object::delete(arg0);
    }

    fun init(arg0: ERASER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<AdminCap>(v0);
        let v1 = Counter{
            id    : 0x2::object::new(arg1),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v1);
        let v2 = Payout{
            id     : 0x2::object::new(arg1),
            amount : 0,
        };
        0x2::transfer::share_object<Payout>(v2);
        let v3 = MintConfig{
            id                  : 0x2::object::new(arg1),
            mint_price          : 0,
            max_supply          : 0,
            current_supply      : 0,
            is_paused           : true,
            per_address_limit   : 0,
            per_stage_limit     : 0,
            default_stage_limit : 0,
            payout_address      : @0x0,
            pubkey_bytes        : 0x1::vector::empty<u8>(),
            pubkey_set          : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<MintConfig>(v3);
        let v4 = MintStats{
            id               : 0x2::object::new(arg1),
            per_address      : 0x2::table::new<address, u64>(arg1),
            per_stage        : 0x2::table::new<u64, u64>(arg1),
            per_stage_limits : 0x2::table::new<u64, u64>(arg1),
        };
        0x2::transfer::share_object<MintStats>(v4);
        let v5 = TraitsRegistry{
            id     : 0x2::object::new(arg1),
            traits : 0x2::table::new<0x1::string::String, 0x2::table::Table<0x1::string::String, u64>>(arg1),
        };
        0x2::transfer::share_object<TraitsRegistry>(v5);
        let v6 = PubKey{
            id           : 0x2::object::new(arg1),
            pubkey_bytes : 0x1::vector::empty<u8>(),
            pubkey_set   : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<PubKey>(v6);
    }

    public fun remove_transfer_policy_from_nft(arg0: &mut 0x2::transfer_policy::TransferPolicy<PfpNFT>, arg1: &0x2::transfer_policy::TransferPolicyCap<PfpNFT>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5, 0);
        0x2::transfer_policy::remove_rule<PfpNFT, u64, u64>(arg0, arg1);
    }

    public fun take_and_burn_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5, 0);
        let PfpNFT {
            id          : v0,
            token_id    : _,
            is_revealed : _,
            attributes  : _,
            number      : _,
            url         : _,
        } = 0x2::kiosk::take<PfpNFT>(arg0, arg1, arg2);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

