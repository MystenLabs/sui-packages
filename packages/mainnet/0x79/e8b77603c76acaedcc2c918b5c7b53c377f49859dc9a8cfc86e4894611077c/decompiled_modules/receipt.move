module 0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::receipt {
    struct PurchaseKey has copy, drop, store {
        payment_digest: vector<u8>,
    }

    struct PurchaseReceipt has key {
        id: 0x2::object::UID,
        payment_digest: vector<u8>,
        payer: address,
        journey_id: 0x2::object::ID,
        amount: u64,
        currency: 0x1::type_name::TypeName,
        paid_at_ms: u64,
    }

    struct PurchaseReceiptMinted has copy, drop {
        id: 0x2::object::ID,
        payment_digest: vector<u8>,
        payer: address,
        journey_id: 0x2::object::ID,
        amount: u64,
        currency: 0x1::type_name::TypeName,
        paid_at_ms: u64,
    }

    public fun accepted_coin_types() : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC");
        0x1::vector::push_back<vector<u8>>(v1, b"44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI");
        v0
    }

    public fun amount(arg0: &PurchaseReceipt) : u64 {
        arg0.amount
    }

    public fun currency(arg0: &PurchaseReceipt) : 0x1::type_name::TypeName {
        arg0.currency
    }

    public fun journey_id(arg0: &PurchaseReceipt) : 0x2::object::ID {
        arg0.journey_id
    }

    public(friend) fun mint(arg0: &mut 0x2::object::UID, arg1: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Receipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC");
        0x1::vector::push_back<vector<u8>>(v1, b"44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI");
        mint_accepting(arg0, arg1, arg2, v0, arg3);
    }

    fun mint_accepting(arg0: &mut 0x2::object::UID, arg1: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Receipt, arg2: &0x2::clock::Clock, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::receipt_buyer(arg1);
        assert!(0x2::tx_context::sender(arg4) == v0, 1);
        let v1 = 0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::receipt_coin(arg1);
        assert!(0x1::vector::contains<vector<u8>>(&arg3, 0x1::ascii::as_bytes(0x1::type_name::as_string(&v1))), 2);
        let v2 = *0x2::tx_context::digest(arg4);
        let v3 = PurchaseKey{payment_digest: v2};
        let v4 = 0x2::derived_object::claim<PurchaseKey>(arg0, v3);
        let v5 = 0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::receipt_journey_id(arg1);
        let v6 = 0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::receipt_price_paid(arg1);
        let v7 = 0x2::clock::timestamp_ms(arg2);
        let v8 = PurchaseReceiptMinted{
            id             : 0x2::object::uid_to_inner(&v4),
            payment_digest : v2,
            payer          : v0,
            journey_id     : v5,
            amount         : v6,
            currency       : v1,
            paid_at_ms     : v7,
        };
        0x2::event::emit<PurchaseReceiptMinted>(v8);
        let v9 = PurchaseReceipt{
            id             : v4,
            payment_digest : v2,
            payer          : v0,
            journey_id     : v5,
            amount         : v6,
            currency       : v1,
            paid_at_ms     : v7,
        };
        0x2::transfer::transfer<PurchaseReceipt>(v9, v0);
    }

    public fun paid_at_ms(arg0: &PurchaseReceipt) : u64 {
        arg0.paid_at_ms
    }

    public fun payer(arg0: &PurchaseReceipt) : address {
        arg0.payer
    }

    public fun payment_digest(arg0: &PurchaseReceipt) : vector<u8> {
        arg0.payment_digest
    }

    public fun receipt_address(arg0: 0x2::object::ID, arg1: vector<u8>) : address {
        let v0 = PurchaseKey{payment_digest: arg1};
        0x2::derived_object::derive_address<PurchaseKey>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

