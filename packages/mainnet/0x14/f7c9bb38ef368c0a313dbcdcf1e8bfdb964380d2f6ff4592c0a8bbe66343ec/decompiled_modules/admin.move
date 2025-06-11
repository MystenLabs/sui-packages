module 0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ADMIN has drop {
        dummy_field: bool,
    }

    entry fun add_supporting_coin_type(arg0: &AdminCap, arg1: &mut 0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::Listings, arg2: 0x1::string::String) {
        0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::add_supporting_coin_type(arg1, arg2);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ADMIN>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun remove_supporting_coin_type(arg0: &AdminCap, arg1: &mut 0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::Listings, arg2: 0x1::string::String) {
        0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::remove_supporting_coin_type(arg1, arg2);
    }

    entry fun set_fee_rate(arg0: &AdminCap, arg1: &mut 0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::Listings, arg2: u64) {
        0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::set_fee_rate(arg1, arg2);
    }

    entry fun set_fee_recipient(arg0: &AdminCap, arg1: &mut 0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::Listings, arg2: address) {
        0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::set_fee_recipient(arg1, arg2);
    }

    entry fun set_listing_signer(arg0: &AdminCap, arg1: &mut 0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::Listings, arg2: vector<u8>) {
        0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::set_signer_public_key(arg1, arg2);
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut 0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::Listings, arg2: bool) {
        0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::set_paused(arg1, arg2);
    }

    entry fun set_warranty_price_recipient(arg0: &AdminCap, arg1: &mut 0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::Listings, arg2: address) {
        0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::multisig_escrow::set_warranty_price_recipient(arg1, arg2);
    }

    entry fun warranty_pay_for_ticket<T0>(arg0: &AdminCap, arg1: 0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::warranty::WarrantyClaimTicket, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x14f7c9bb38ef368c0a313dbcdcf1e8bfdb964380d2f6ff4592c0a8bbe66343ec::warranty::pay_for_ticket<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

