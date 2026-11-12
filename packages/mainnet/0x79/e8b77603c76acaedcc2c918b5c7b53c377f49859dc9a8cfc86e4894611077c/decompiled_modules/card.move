module 0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::card {
    struct CARD has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        cards: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        sessions: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        receipts: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Card has key {
        id: 0x2::object::UID,
        card: 0x2::object::ID,
        card_fingerprint: vector<u8>,
        walrus_id: 0x1::string::String,
        version: u64,
        parent: 0x1::option::Option<0x2::object::ID>,
        parent_card_fingerprint: 0x1::option::Option<vector<u8>>,
        signed_at: u64,
        domain: 0x1::string::String,
        schema_version: u64,
        owner: address,
        attestation_hash: vector<u8>,
        receipt_fingerprint: 0x2::object::ID,
    }

    struct ListingCap has key {
        id: 0x2::object::UID,
    }

    struct ListingHidden has copy, drop {
        card: 0x2::object::ID,
        reason: 0x1::string::String,
        at: u64,
    }

    struct ListingRestored has copy, drop {
        card: 0x2::object::ID,
        reason: 0x1::string::String,
        at: u64,
    }

    struct CardCreated has copy, drop {
        id: 0x2::object::ID,
        card: 0x2::object::ID,
        owner: address,
        version: u64,
        card_fingerprint: vector<u8>,
        walrus_id: 0x1::string::String,
        signed_at: u64,
        domain: 0x1::string::String,
        session: 0x2::object::ID,
        attestation_hash: vector<u8>,
        receipt_fingerprint: 0x2::object::ID,
    }

    struct CardPublished has copy, drop {
        id: 0x2::object::ID,
        card: 0x2::object::ID,
        owner: address,
        version: u64,
        card_fingerprint: vector<u8>,
        walrus_id: 0x1::string::String,
        signed_at: u64,
        parent: 0x2::object::ID,
        parent_card_fingerprint: vector<u8>,
        attestation_hash: vector<u8>,
        receipt_fingerprint: 0x2::object::ID,
    }

    public fun card(arg0: &Card) : 0x2::object::ID {
        arg0.card
    }

    public fun attestation_hash(arg0: &Card) : vector<u8> {
        arg0.attestation_hash
    }

    public fun card_fingerprint(arg0: &Card) : vector<u8> {
        arg0.card_fingerprint
    }

    fun card_key(arg0: address, arg1: &0x1::string::String) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg1));
        v0
    }

    public fun card_of(arg0: &Registry, arg1: address, arg2: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        let v0 = card_key(arg1, &arg2);
        if (0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.cards, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.cards, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun card_of_receipt(arg0: &Registry, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.receipts, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.receipts, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun card_of_session(arg0: &Registry, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.sessions, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.sessions, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun check_fields(arg0: &vector<u8>, arg1: &0x1::string::String) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 4);
        let v0 = 0x1::string::length(arg1);
        assert!(v0 >= 1 && v0 <= 64, 5);
    }

    entry fun create_card(arg0: &mut Registry, arg1: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session, arg2: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Journey, arg3: &0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::receipt::PurchaseReceipt, arg4: vector<u8>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::buyer(arg1) == v0, 1);
        assert!(0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::journey_id(arg1) == 0x2::object::id<0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Journey>(arg2), 14);
        assert!(0x2::clock::timestamp_ms(arg8) < 0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::draft::draft_until_ms(arg1, arg2), 15);
        let v1 = 0x2::object::id<0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.sessions, v1), 13);
        assert!(0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::receipt::payer(arg3) == v0, 16);
        assert!(0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::receipt::journey_id(arg3) == 0x2::object::id<0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Journey>(arg2), 17);
        assert!(0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::receipt::paid_at_ms(arg3) == 0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::draft::purchase_ms(arg1, arg2), 18);
        assert!(0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::receipt::amount(arg3) >= 50000000, 20);
        let v2 = 0x2::object::id<0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::receipt::PurchaseReceipt>(arg3);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.receipts, v2), 19);
        check_fields(&arg4, &arg5);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 11);
        assert!(is_valid_domain(&arg6), 6);
        let v3 = card_key(v0, &arg6);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.cards, v3), 10);
        let v4 = 0x2::object::new(arg9);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = 0x2::clock::timestamp_ms(arg8);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.cards, v3, v5);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.sessions, v1, v5);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.receipts, v2, v5);
        let v7 = CardCreated{
            id                  : v5,
            card                : v5,
            owner               : v0,
            version             : 1,
            card_fingerprint    : arg4,
            walrus_id           : arg5,
            signed_at           : v6,
            domain              : arg6,
            session             : 0x2::object::id<0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session>(arg1),
            attestation_hash    : arg7,
            receipt_fingerprint : v2,
        };
        0x2::event::emit<CardCreated>(v7);
        let v8 = Card{
            id                      : v4,
            card                    : v5,
            card_fingerprint        : arg4,
            walrus_id               : arg5,
            version                 : 1,
            parent                  : 0x1::option::none<0x2::object::ID>(),
            parent_card_fingerprint : 0x1::option::none<vector<u8>>(),
            signed_at               : v6,
            domain                  : arg6,
            schema_version          : 1,
            owner                   : v0,
            attestation_hash        : arg7,
            receipt_fingerprint     : v2,
        };
        0x2::transfer::transfer<Card>(v8, v0);
    }

    public fun current_schema_version() : u64 {
        1
    }

    public fun domain(arg0: &Card) : 0x1::string::String {
        arg0.domain
    }

    entry fun hide_listing(arg0: &ListingCap, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert!(is_listing_reason(&arg2), 12);
        let v0 = ListingHidden{
            card   : arg1,
            reason : arg2,
            at     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ListingHidden>(v0);
    }

    fun init(arg0: CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id       : 0x2::object::new(arg1),
            cards    : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg1),
            sessions : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            receipts : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = 0x2::package::claim<CARD>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"version"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{domain}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{version}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://meishi.wal.app/card/{domain}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"The meishi of {domain}, signed by its own wallet. Read and use it at https://meishi.page. This link opens the Walrus copy, which anyone can check."));
        let v6 = 0x2::display::new_with_fields<Card>(&v1, v2, v4, arg1);
        0x2::display::update_version<Card>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Card>>(v6, @0x9b282b46ed5f29ad0f754863a9f3af83133eefa85a91255019aac7c86b9acfdd);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, @0x9b282b46ed5f29ad0f754863a9f3af83133eefa85a91255019aac7c86b9acfdd);
        let v7 = ListingCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ListingCap>(v7, @0x348cfb27da8730a95e218af5c57e8d5cc2919334ebe482003b67a745903e11f5);
    }

    public fun is_listing_reason(arg0: &0x1::string::String) : bool {
        let v0 = vector[b"impersonation", b"false_or_misleading", b"defamatory", b"infringes_rights", b"unlawful", b"court_order"];
        0x1::vector::contains<vector<u8>>(&v0, 0x1::string::as_bytes(arg0))
    }

    public fun is_valid_domain(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0 || v1 > 253) {
            return false
        };
        let v2 = *0x1::vector::borrow<u8>(v0, 0);
        let v3 = *0x1::vector::borrow<u8>(v0, v1 - 1);
        let v4 = if (v2 == 46) {
            true
        } else if (v2 == 45) {
            true
        } else if (v3 == 46) {
            true
        } else {
            v3 == 45
        };
        if (v4) {
            return false
        };
        let v5 = 0;
        let v6 = 0;
        while (v6 < v1) {
            let v7 = *0x1::vector::borrow<u8>(v0, v6);
            let v8 = if (v7 >= 97 && v7 <= 122) {
                true
            } else if (v7 >= 48 && v7 <= 57) {
                true
            } else if (v7 == 45) {
                true
            } else {
                v7 == 46
            };
            if (!v8) {
                return false
            };
            if (v7 == 46) {
                v5 = v5 + 1;
            };
            v6 = v6 + 1;
        };
        v5 > 0
    }

    public fun min_card_price() : u64 {
        50000000
    }

    public fun min_version_gap_ms() : u64 {
        86400000
    }

    public fun mint_receipt(arg0: &mut Registry, arg1: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Receipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::receipt::mint(&mut arg0.id, arg1, arg2, arg3);
    }

    fun next_version(arg0: &Card, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Card {
        Card{
            id                      : 0x2::object::new(arg5),
            card                    : arg0.card,
            card_fingerprint        : arg1,
            walrus_id               : arg2,
            version                 : arg0.version + 1,
            parent                  : 0x1::option::some<0x2::object::ID>(0x2::object::id<Card>(arg0)),
            parent_card_fingerprint : 0x1::option::some<vector<u8>>(arg0.card_fingerprint),
            signed_at               : arg3,
            domain                  : arg0.domain,
            schema_version          : 1,
            owner                   : arg0.owner,
            attestation_hash        : arg4,
            receipt_fingerprint     : arg0.receipt_fingerprint,
        }
    }

    public fun owner(arg0: &Card) : address {
        arg0.owner
    }

    public fun parent(arg0: &Card) : 0x1::option::Option<0x2::object::ID> {
        arg0.parent
    }

    public fun parent_card_fingerprint(arg0: &Card) : 0x1::option::Option<vector<u8>> {
        arg0.parent_card_fingerprint
    }

    entry fun publish_version(arg0: Card, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.owner == v0, 2);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 11);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= arg0.signed_at + 86400000, 3);
        check_fields(&arg1, &arg2);
        let v2 = next_version(&arg0, arg1, arg2, v1, arg3, arg5);
        let v3 = CardPublished{
            id                      : 0x2::object::id<Card>(&v2),
            card                    : v2.card,
            owner                   : v0,
            version                 : v2.version,
            card_fingerprint        : v2.card_fingerprint,
            walrus_id               : v2.walrus_id,
            signed_at               : v1,
            parent                  : 0x2::object::id<Card>(&arg0),
            parent_card_fingerprint : arg0.card_fingerprint,
            attestation_hash        : v2.attestation_hash,
            receipt_fingerprint     : v2.receipt_fingerprint,
        };
        0x2::event::emit<CardPublished>(v3);
        0x2::transfer::freeze_object<Card>(arg0);
        0x2::transfer::transfer<Card>(v2, v0);
    }

    public fun receipt_fingerprint(arg0: &Card) : 0x2::object::ID {
        arg0.receipt_fingerprint
    }

    public fun receipt_used(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.receipts, arg1)
    }

    entry fun restore_listing(arg0: &ListingCap, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert!(is_listing_reason(&arg2), 12);
        let v0 = ListingRestored{
            card   : arg1,
            reason : arg2,
            at     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ListingRestored>(v0);
    }

    public fun schema_version(arg0: &Card) : u64 {
        arg0.schema_version
    }

    public fun session_used(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.sessions, arg1)
    }

    public fun signed_at(arg0: &Card) : u64 {
        arg0.signed_at
    }

    public fun transfer_listing_cap(arg0: ListingCap, arg1: address) {
        0x2::transfer::transfer<ListingCap>(arg0, arg1);
    }

    public fun version(arg0: &Card) : u64 {
        arg0.version
    }

    public fun walrus_id(arg0: &Card) : 0x1::string::String {
        arg0.walrus_id
    }

    // decompiled from Move bytecode v7
}

