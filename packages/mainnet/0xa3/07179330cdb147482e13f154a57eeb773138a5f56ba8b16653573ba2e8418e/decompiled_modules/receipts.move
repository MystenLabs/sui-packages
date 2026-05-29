module 0xa307179330cdb147482e13f154a57eeb773138a5f56ba8b16653573ba2e8418e::receipts {
    struct ReceiptRegistry has key {
        id: 0x2::object::UID,
        total_receipts: u64,
        total_protocols: u64,
        fee: u64,
        treasury: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        admin: address,
        protocols: 0x2::table::Table<address, vector<u8>>,
    }

    struct ReceiptAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        receipt_id: u64,
        protocol: address,
        issuer: address,
        tx_hash: vector<u8>,
        blob_id: vector<u8>,
        blob_hash: vector<u8>,
        asset: vector<u8>,
        action: vector<u8>,
        amount: u64,
        currency: vector<u8>,
        timestamp: u64,
        namespace: vector<u8>,
    }

    struct ReceiptAnchored has copy, drop {
        receipt_id: u64,
        protocol: address,
        issuer: address,
        tx_hash: vector<u8>,
        blob_id: vector<u8>,
        asset: vector<u8>,
        action: vector<u8>,
        amount: u64,
        timestamp: u64,
        namespace: vector<u8>,
    }

    struct ProtocolRegistered has copy, drop {
        protocol: address,
        name: vector<u8>,
    }

    public entry fun anchor_receipt(arg0: &mut ReceiptRegistry, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) >= arg0.fee, 2);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.treasury, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        let v0 = arg0.total_receipts;
        arg0.total_receipts = arg0.total_receipts + 1;
        let v1 = 0x2::tx_context::sender(arg12);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = ReceiptAnchored{
            receipt_id : v0,
            protocol   : v1,
            issuer     : v1,
            tx_hash    : arg3,
            blob_id    : arg4,
            asset      : arg6,
            action     : arg7,
            amount     : arg8,
            timestamp  : v2,
            namespace  : arg10,
        };
        0x2::event::emit<ReceiptAnchored>(v3);
        let v4 = Receipt{
            id         : 0x2::object::new(arg12),
            receipt_id : v0,
            protocol   : v1,
            issuer     : v1,
            tx_hash    : arg3,
            blob_id    : arg4,
            blob_hash  : arg5,
            asset      : arg6,
            action     : arg7,
            amount     : arg8,
            currency   : arg9,
            timestamp  : v2,
            namespace  : arg10,
        };
        0x2::transfer::transfer<Receipt>(v4, arg11);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = ReceiptRegistry{
            id              : 0x2::object::new(arg0),
            total_receipts  : 0,
            total_protocols : 0,
            fee             : 1000,
            treasury        : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            admin           : v0,
            protocols       : 0x2::table::new<address, vector<u8>>(arg0),
        };
        0x2::transfer::share_object<ReceiptRegistry>(v1);
        let v2 = ReceiptAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ReceiptAdminCap>(v2, v0);
    }

    public fun receipt_blob_id(arg0: &Receipt) : &vector<u8> {
        &arg0.blob_id
    }

    public fun receipt_id(arg0: &Receipt) : u64 {
        arg0.receipt_id
    }

    public entry fun register_protocol(arg0: &mut ReceiptRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, vector<u8>>(&arg0.protocols, v0)) {
            arg0.total_protocols = arg0.total_protocols + 1;
        };
        if (0x2::table::contains<address, vector<u8>>(&arg0.protocols, v0)) {
            0x2::table::remove<address, vector<u8>>(&mut arg0.protocols, v0);
        };
        0x2::table::add<address, vector<u8>>(&mut arg0.protocols, v0, arg1);
        let v1 = ProtocolRegistered{
            protocol : v0,
            name     : arg1,
        };
        0x2::event::emit<ProtocolRegistered>(v1);
    }

    public entry fun set_fee(arg0: &mut ReceiptRegistry, arg1: &ReceiptAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.fee = arg2;
    }

    public fun total_protocols(arg0: &ReceiptRegistry) : u64 {
        arg0.total_protocols
    }

    public fun total_receipts(arg0: &ReceiptRegistry) : u64 {
        arg0.total_receipts
    }

    public entry fun withdraw_treasury(arg0: &mut ReceiptRegistry, arg1: &ReceiptAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.treasury, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.treasury)), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

