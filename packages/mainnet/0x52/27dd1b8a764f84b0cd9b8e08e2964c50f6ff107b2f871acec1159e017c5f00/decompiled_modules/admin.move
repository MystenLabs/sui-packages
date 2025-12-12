module 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ADMIN has drop {
        dummy_field: bool,
    }

    entry fun add_allowed_version(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: u64) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::add_allowed_version(arg1, arg2);
    }

    entry fun add_balance<T0>(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::PoolRegistry, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>) {
        abort 901
    }

    entry fun add_pool<T0>(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::PoolRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::add_pool<T0>(arg1, arg2);
    }

    entry fun add_supporting_coin_type(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: 0x1::string::String) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::add_supporting_coin_type(arg1, arg2);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ADMIN>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun init_version_registry(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: &mut 0x2::tx_context::TxContext) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::set_version_registry(arg1, arg2);
    }

    entry fun initialize_debt_registry(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::initialize_pool_registry(arg1);
    }

    entry fun initialize_message_registry(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: &mut 0x2::tx_context::TxContext) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::set_message_registry(arg1, arg2);
    }

    entry fun initialize_pia_registry(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::initialize_pia_registry(arg1);
    }

    entry fun mint_admin_listing_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::AdminListingCap>(0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::mint_admin_listing_cap(arg2), arg1);
    }

    entry fun pia_add_balance<T0>(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::PiaRegistry, arg2: 0x2::coin::Coin<T0>) {
        abort 901
    }

    entry fun pia_add_pool<T0>(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::PiaRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::add_pool<T0>(arg1, arg2);
    }

    entry fun remove_allowed_version(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: u64) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::remove_allowed_version(arg1, arg2);
    }

    entry fun remove_supporting_coin_type(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: 0x1::string::String) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::remove_supporting_coin_type(arg1, arg2);
    }

    entry fun set_fee_rate(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: u64) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::set_fee_rate(arg1, arg2);
    }

    entry fun set_fee_recipient(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: address) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::set_fee_recipient(arg1, arg2);
    }

    entry fun set_listing_signer(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: vector<u8>) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::set_signer_public_key(arg1, arg2);
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: bool) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::set_paused(arg1, arg2);
    }

    entry fun set_version(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: u64) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::set_version(arg1, arg2);
    }

    entry fun set_warranty_price_recipient(arg0: &AdminCap, arg1: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::Listings, arg2: address) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow::set_warranty_price_recipient(arg1, arg2);
    }

    entry fun warranty_pay_for_ticket<T0>(arg0: &AdminCap, arg1: 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::WarrantyClaimTicket, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::pay_for_ticket<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

