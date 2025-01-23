module 0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::marketplace {
    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    struct KioskRegistry has store, key {
        id: 0x2::object::UID,
        kiosks: 0x2::table::Table<address, 0x2::object::ID>,
    }

    public fun confirm_request(arg0: &0x2::transfer_policy::TransferPolicy<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>, arg1: 0x2::transfer_policy::TransferRequest<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>(arg0, arg1);
    }

    public fun buy(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT, 0x2::transfer_policy::TransferRequest<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>) {
        0x2::kiosk::purchase<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>(arg0, arg1, arg2)
    }

    public fun create_kiosk(arg0: &mut KioskRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.kiosks, v0), 1000);
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let v3 = v1;
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.kiosks, v0, 0x2::object::id<0x2::kiosk::Kiosk>(&v3));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, v0);
    }

    public fun create_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MARKETPLACE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = KioskRegistry{
            id     : 0x2::object::new(arg1),
            kiosks : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::public_share_object<KioskRegistry>(v0);
    }

    public fun place_and_list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT, arg3: u64) {
        0x2::kiosk::place<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>(arg0, arg1, arg2);
        0x2::kiosk::list<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>(arg0, arg1, 0x2::object::id<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>(&arg2), arg3);
    }

    public fun remove(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : 0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT {
        0x2::kiosk::take<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>(arg0, arg1, arg2)
    }

    public fun update_price(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::delist<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>(arg0, arg1, arg2);
        0x2::kiosk::list<0x604d5a2093e8d9d95f32b9d0ae11e731c240194ef611d3898cd23def2d27dd66::agent_nft::AGENT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

