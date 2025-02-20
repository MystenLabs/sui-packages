module 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::referrals {
    struct Referral has copy, drop, store {
        receiver: address,
        percentage: u16,
    }

    struct ReferralTicket has store {
        creator: address,
        uses: u64,
    }

    struct ReferralTable has key {
        id: 0x2::object::UID,
        referral_table: 0x2::table::Table<vector<u8>, ReferralTicket>,
    }

    struct CreateReferralTicket has copy, drop {
        ticket_hash: vector<u8>,
    }

    public entry fun add_referral_ticket(arg0: &mut ReferralTable, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::address::to_bytes(v0);
        let v2 = 0x2::hash::keccak256(&v1);
        assert!(!0x2::table::contains<vector<u8>, ReferralTicket>(&arg0.referral_table, v2), 0);
        let v3 = ReferralTicket{
            creator : v0,
            uses    : 0,
        };
        0x2::table::add<vector<u8>, ReferralTicket>(&mut arg0.referral_table, v2, v3);
        let v4 = CreateReferralTicket{ticket_hash: v2};
        0x2::event::emit<CreateReferralTicket>(v4);
        v2
    }

    public(friend) fun calculate_referrals(arg0: 0x1::option::Option<Referral>, arg1: u64) : (u64, address) {
        let v0 = Referral{
            receiver   : @0x0,
            percentage : 0,
        };
        let v1 = 0x1::option::get_with_default<Referral>(&arg0, v0);
        ((((arg1 as u128) * (v1.percentage as u128) / 10000) as u64), v1.receiver)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralTable{
            id             : 0x2::object::new(arg0),
            referral_table : 0x2::table::new<vector<u8>, ReferralTicket>(arg0),
        };
        0x2::transfer::share_object<ReferralTable>(v0);
    }

    public(friend) fun use_referral(arg0: &mut ReferralTable, arg1: vector<u8>) : Referral {
        assert!(0x2::table::contains<vector<u8>, ReferralTicket>(&arg0.referral_table, arg1), 1);
        let v0 = 0x2::table::borrow_mut<vector<u8>, ReferralTicket>(&mut arg0.referral_table, arg1);
        let v1 = if (v0.uses == 0) {
            5000
        } else if (v0.uses == 1) {
            3000
        } else if (v0.uses == 2) {
            1500
        } else {
            500
        };
        let v2 = Referral{
            receiver   : v0.creator,
            percentage : v1,
        };
        v0.uses = v0.uses + 1;
        v2
    }

    // decompiled from Move bytecode v6
}

