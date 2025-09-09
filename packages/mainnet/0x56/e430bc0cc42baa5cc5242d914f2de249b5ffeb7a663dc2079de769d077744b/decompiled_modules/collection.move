module 0x56e430bc0cc42baa5cc5242d914f2de249b5ffeb7a663dc2079de769d077744b::collection {
    struct Blub has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ArtTicket has store, key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        used: bool,
    }

    struct GoldPass has store, key {
        id: 0x2::object::UID,
    }

    struct SilverPass has store, key {
        id: 0x2::object::UID,
    }

    struct BronzePass has store, key {
        id: 0x2::object::UID,
    }

    struct Gate has store, key {
        id: 0x2::object::UID,
        admin: address,
        price_mist: u64,
        supply: u64,
        minted: u64,
        agg_base: 0x1::string::String,
        collection_name: 0x1::string::String,
        description: 0x1::string::String,
        open_gold_ms: u64,
        open_silver_ms: u64,
        open_bronze_ms: u64,
    }

    struct PassSale has store, key {
        id: 0x2::object::UID,
        admin: address,
        price_gold_mist: u64,
        price_silver_mist: u64,
        price_bronze_mist: u64,
        open_gold: bool,
        open_silver: bool,
        open_bronze: bool,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct GateCreated has copy, drop {
        gate_id: 0x2::object::ID,
        admin: address,
        price_mist: u64,
        supply: u64,
    }

    struct GatePriceUpdated has copy, drop {
        gate_id: 0x2::object::ID,
        old_price_mist: u64,
        new_price_mist: u64,
    }

    struct GateOpenTimesUpdated has copy, drop {
        gate_id: 0x2::object::ID,
        gold_ms: u64,
        silver_ms: u64,
        bronze_ms: u64,
    }

    struct GateSupplyUpdated has copy, drop {
        gate_id: 0x2::object::ID,
        old_supply: u64,
        new_supply: u64,
    }

    struct TicketCreated has copy, drop {
        ticket_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
    }

    struct PassSaleCreated has copy, drop {
        sale_id: 0x2::object::ID,
        admin: address,
        price_gold_mist: u64,
        price_silver_mist: u64,
        price_bronze_mist: u64,
        open_gold: bool,
        open_silver: bool,
        open_bronze: bool,
    }

    struct PassSalePricesUpdated has copy, drop {
        sale_id: 0x2::object::ID,
        price_gold_mist: u64,
        price_silver_mist: u64,
        price_bronze_mist: u64,
    }

    struct PassSaleOpenFlagsUpdated has copy, drop {
        sale_id: 0x2::object::ID,
        open_gold: bool,
        open_silver: bool,
        open_bronze: bool,
    }

    struct PassPurchased has copy, drop {
        pass_type: 0x1::string::String,
        buyer: address,
        amount_mist: u64,
    }

    struct BlubMinted has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        tier: 0x1::string::String,
        price_mist: u64,
        blob_id: 0x1::string::String,
    }

    struct ImageHostUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        new_host: 0x1::string::String,
    }

    public fun airdrop_bronze(arg0: &Gate, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 312);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = BronzePass{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<BronzePass>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    public fun airdrop_gold(arg0: &Gate, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 310);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = GoldPass{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<GoldPass>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    public fun airdrop_silver(arg0: &Gate, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 311);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = SilverPass{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<SilverPass>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    public fun buy_pass_bronze(arg0: &Gate, arg1: &PassSale, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.open_bronze, 416);
        assert!(arg1.price_bronze_mist > 0, 417);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.price_bronze_mist, 418);
        assert!(arg1.admin == arg0.admin, 421);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.admin);
        let v0 = BronzePass{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<BronzePass>(v0, 0x2::tx_context::sender(arg3));
        let v1 = PassPurchased{
            pass_type   : 0x1::string::utf8(b"Bronze"),
            buyer       : 0x2::tx_context::sender(arg3),
            amount_mist : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<PassPurchased>(v1);
    }

    public fun buy_pass_gold(arg0: &Gate, arg1: &PassSale, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.open_gold, 410);
        assert!(arg1.price_gold_mist > 0, 411);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.price_gold_mist, 412);
        assert!(arg1.admin == arg0.admin, 419);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.admin);
        let v0 = GoldPass{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<GoldPass>(v0, 0x2::tx_context::sender(arg3));
        let v1 = PassPurchased{
            pass_type   : 0x1::string::utf8(b"Gold"),
            buyer       : 0x2::tx_context::sender(arg3),
            amount_mist : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<PassPurchased>(v1);
    }

    public fun buy_pass_silver(arg0: &Gate, arg1: &PassSale, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.open_silver, 413);
        assert!(arg1.price_silver_mist > 0, 414);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.price_silver_mist, 415);
        assert!(arg1.admin == arg0.admin, 420);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.admin);
        let v0 = SilverPass{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<SilverPass>(v0, 0x2::tx_context::sender(arg3));
        let v1 = PassPurchased{
            pass_type   : 0x1::string::utf8(b"Silver"),
            buyer       : 0x2::tx_context::sender(arg3),
            amount_mist : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<PassPurchased>(v1);
    }

    public fun create_ticket(arg0: &Gate, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 300);
        let v0 = ArtTicket{
            id      : 0x2::object::new(arg2),
            blob_id : arg1,
            used    : false,
        };
        let v1 = TicketCreated{
            ticket_id : 0x2::object::id<ArtTicket>(&v0),
            blob_id   : 0x1::string::sub_string(&v0.blob_id, 0, 0x1::string::length(&v0.blob_id)),
        };
        0x2::event::emit<TicketCreated>(v1);
        0x2::transfer::public_share_object<ArtTicket>(v0);
    }

    public fun create_tickets(arg0: &Gate, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 301);
        while (0x1::vector::length<0x1::string::String>(&arg1) > 0) {
            let v0 = ArtTicket{
                id      : 0x2::object::new(arg2),
                blob_id : 0x1::vector::pop_back<0x1::string::String>(&mut arg1),
                used    : false,
            };
            let v1 = TicketCreated{
                ticket_id : 0x2::object::id<ArtTicket>(&v0),
                blob_id   : 0x1::string::sub_string(&v0.blob_id, 0, 0x1::string::length(&v0.blob_id)),
            };
            0x2::event::emit<TicketCreated>(v1);
            0x2::transfer::public_share_object<ArtTicket>(v0);
        };
    }

    public fun get_pass_open(arg0: &PassSale) : (bool, bool, bool) {
        (arg0.open_gold, arg0.open_silver, arg0.open_bronze)
    }

    public fun get_pass_prices(arg0: &PassSale) : (u64, u64, u64) {
        (arg0.price_gold_mist, arg0.price_silver_mist, arg0.price_bronze_mist)
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<COLLECTION>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_gate(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Gate{
            id              : 0x2::object::new(arg8),
            admin           : 0x2::tx_context::sender(arg8),
            price_mist      : arg0,
            supply          : arg1,
            minted          : 0,
            agg_base        : arg2,
            collection_name : arg3,
            description     : arg4,
            open_gold_ms    : arg5,
            open_silver_ms  : arg6,
            open_bronze_ms  : arg7,
        };
        let v1 = GateCreated{
            gate_id    : 0x2::object::id<Gate>(&v0),
            admin      : v0.admin,
            price_mist : arg0,
            supply     : arg1,
        };
        0x2::event::emit<GateCreated>(v1);
        0x2::transfer::public_share_object<Gate>(v0);
    }

    public fun init_pass_sale(arg0: &Gate, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 400);
        let v0 = PassSale{
            id                : 0x2::object::new(arg7),
            admin             : arg0.admin,
            price_gold_mist   : arg1,
            price_silver_mist : arg2,
            price_bronze_mist : arg3,
            open_gold         : arg4,
            open_silver       : arg5,
            open_bronze       : arg6,
        };
        let v1 = PassSaleCreated{
            sale_id           : 0x2::object::id<PassSale>(&v0),
            admin             : v0.admin,
            price_gold_mist   : arg1,
            price_silver_mist : arg2,
            price_bronze_mist : arg3,
            open_gold         : arg4,
            open_silver       : arg5,
            open_bronze       : arg6,
        };
        0x2::event::emit<PassSaleCreated>(v1);
        0x2::transfer::public_share_object<PassSale>(v0);
    }

    public fun lock_nft_into_kiosk(arg0: Blub, arg1: &0x2::transfer_policy::TransferPolicy<Blub>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::lock<Blub>(arg2, arg3, arg1, arg0);
    }

    public fun mint_admin_free(arg0: &mut Gate, arg1: &mut ArtTicket, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 313);
        assert!(arg0.supply == 0 || arg0.minted < arg0.supply, 314);
        assert!(!arg1.used, 315);
        arg1.used = true;
        let v0 = 0x1::string::sub_string(&arg0.agg_base, 0, 0x1::string::length(&arg0.agg_base));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::string::sub_string(&arg1.blob_id, 0, 0x1::string::length(&arg1.blob_id)));
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"BlobId"), 0x1::string::sub_string(&arg1.blob_id, 0, 0x1::string::length(&arg1.blob_id)));
        let v2 = Blub{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::sub_string(&arg0.collection_name, 0, 0x1::string::length(&arg0.collection_name)),
            image_url   : v0,
            description : 0x1::string::sub_string(&arg0.description, 0, 0x1::string::length(&arg0.description)),
            attributes  : v1,
        };
        let v3 = BlubMinted{
            nft_id     : 0x2::object::id<Blub>(&v2),
            minter     : 0x2::tx_context::sender(arg2),
            tier       : 0x1::string::utf8(b"Standard"),
            price_mist : 0,
            blob_id    : 0x1::string::sub_string(&arg1.blob_id, 0, 0x1::string::length(&arg1.blob_id)),
        };
        0x2::event::emit<BlubMinted>(v3);
        0x2::transfer::public_transfer<Blub>(v2, 0x2::tx_context::sender(arg2));
        arg0.minted = arg0.minted + 1;
    }

    public fun mint_bronze(arg0: &mut Gate, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: BronzePass, arg3: &mut ArtTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.open_bronze_ms, 202);
        let BronzePass { id: v0 } = arg2;
        0x2::object::delete(v0);
        mint_common(arg0, arg1, arg3, 0x1::string::utf8(b"Bronze"), arg5);
    }

    fun mint_common(arg0: &mut Gate, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut ArtTicket, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.supply == 0 || arg0.minted < arg0.supply, 220);
        assert!(!arg2.used, 221);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.price_mist, 222);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.admin);
        arg2.used = true;
        let v0 = 0x1::string::sub_string(&arg0.agg_base, 0, 0x1::string::length(&arg0.agg_base));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::string::sub_string(&arg2.blob_id, 0, 0x1::string::length(&arg2.blob_id)));
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"BlobId"), 0x1::string::sub_string(&arg2.blob_id, 0, 0x1::string::length(&arg2.blob_id)));
        let v2 = Blub{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::sub_string(&arg0.collection_name, 0, 0x1::string::length(&arg0.collection_name)),
            image_url   : v0,
            description : 0x1::string::sub_string(&arg0.description, 0, 0x1::string::length(&arg0.description)),
            attributes  : v1,
        };
        let v3 = BlubMinted{
            nft_id     : 0x2::object::id<Blub>(&v2),
            minter     : 0x2::tx_context::sender(arg4),
            tier       : 0x1::string::sub_string(&arg3, 0, 0x1::string::length(&arg3)),
            price_mist : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            blob_id    : 0x1::string::sub_string(&arg2.blob_id, 0, 0x1::string::length(&arg2.blob_id)),
        };
        0x2::event::emit<BlubMinted>(v3);
        0x2::transfer::public_transfer<Blub>(v2, 0x2::tx_context::sender(arg4));
        arg0.minted = arg0.minted + 1;
    }

    public fun mint_gold(arg0: &mut Gate, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: GoldPass, arg3: &mut ArtTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.open_gold_ms, 200);
        let GoldPass { id: v0 } = arg2;
        0x2::object::delete(v0);
        mint_common(arg0, arg1, arg3, 0x1::string::utf8(b"Gold"), arg5);
    }

    public fun mint_silver(arg0: &mut Gate, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: SilverPass, arg3: &mut ArtTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.open_silver_ms, 201);
        let SilverPass { id: v0 } = arg2;
        0x2::object::delete(v0);
        mint_common(arg0, arg1, arg3, 0x1::string::utf8(b"Silver"), arg5);
    }

    public fun owner_update_image_host(arg0: &mut Blub, arg1: 0x1::string::String) {
        let v0 = 0x1::string::utf8(b"BlobId");
        let v1 = 0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0);
        let v2 = 0x1::string::sub_string(&arg1, 0, 0x1::string::length(&arg1));
        0x1::string::append(&mut v2, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v2, 0x1::string::sub_string(v1, 0, 0x1::string::length(v1)));
        arg0.image_url = v2;
        let v3 = ImageHostUpdated{
            nft_id   : 0x2::object::id<Blub>(arg0),
            new_host : 0x1::string::sub_string(&arg1, 0, 0x1::string::length(&arg1)),
        };
        0x2::event::emit<ImageHostUpdated>(v3);
    }

    public fun set_agg_base(arg0: &mut Gate, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 502);
        arg0.agg_base = arg1;
    }

    public fun set_metadata(arg0: &mut Gate, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 501);
        arg0.collection_name = arg1;
        arg0.description = arg2;
    }

    public fun set_open_times(arg0: &mut Gate, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 503);
        assert!(arg1 >= arg0.open_gold_ms, 504);
        assert!(arg2 >= arg0.open_silver_ms, 505);
        assert!(arg3 >= arg0.open_bronze_ms, 506);
        assert!(arg1 <= arg2 && arg2 <= arg3, 507);
        arg0.open_gold_ms = arg1;
        arg0.open_silver_ms = arg2;
        arg0.open_bronze_ms = arg3;
        let v0 = GateOpenTimesUpdated{
            gate_id   : 0x2::object::id<Gate>(arg0),
            gold_ms   : arg1,
            silver_ms : arg2,
            bronze_ms : arg3,
        };
        0x2::event::emit<GateOpenTimesUpdated>(v0);
    }

    public fun set_pass_open(arg0: &Gate, arg1: &mut PassSale, arg2: bool, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin && arg1.admin == arg0.admin, 402);
        arg1.open_gold = arg2;
        arg1.open_silver = arg3;
        arg1.open_bronze = arg4;
        let v0 = PassSaleOpenFlagsUpdated{
            sale_id     : 0x2::object::id<PassSale>(arg1),
            open_gold   : arg2,
            open_silver : arg3,
            open_bronze : arg4,
        };
        0x2::event::emit<PassSaleOpenFlagsUpdated>(v0);
    }

    public fun set_pass_prices(arg0: &Gate, arg1: &mut PassSale, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin && arg1.admin == arg0.admin, 401);
        arg1.price_gold_mist = arg2;
        arg1.price_silver_mist = arg3;
        arg1.price_bronze_mist = arg4;
        let v0 = PassSalePricesUpdated{
            sale_id           : 0x2::object::id<PassSale>(arg1),
            price_gold_mist   : arg2,
            price_silver_mist : arg3,
            price_bronze_mist : arg4,
        };
        0x2::event::emit<PassSalePricesUpdated>(v0);
    }

    public fun set_price(arg0: &mut Gate, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 500);
        arg0.price_mist = arg1;
        let v0 = GatePriceUpdated{
            gate_id        : 0x2::object::id<Gate>(arg0),
            old_price_mist : arg0.price_mist,
            new_price_mist : arg1,
        };
        0x2::event::emit<GatePriceUpdated>(v0);
    }

    public fun set_supply(arg0: &mut Gate, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 508);
        if (arg1 > 0) {
            assert!(arg1 >= arg0.minted, 509);
        };
        arg0.supply = arg1;
        let v0 = GateSupplyUpdated{
            gate_id    : 0x2::object::id<Gate>(arg0),
            old_supply : arg0.supply,
            new_supply : arg1,
        };
        0x2::event::emit<GateSupplyUpdated>(v0);
    }

    public fun setup_display_nft(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        let v4 = 0x2::display::new_with_fields<Blub>(arg0, v0, v2, arg2);
        0x2::display::update_version<Blub>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Blub>>(v4, 0x2::tx_context::sender(arg2));
    }

    public fun setup_display_passes(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gold Pass"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Early access pass: GOLD"));
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::sub_string(&arg1, 0, 0x1::string::length(&arg1)));
        let v4 = 0x2::display::new_with_fields<GoldPass>(arg0, v0, v2, arg5);
        0x2::display::update_version<GoldPass>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<GoldPass>>(v4, 0x2::tx_context::sender(arg5));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_url"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Silver Pass"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Early access pass: SILVER"));
        0x1::vector::push_back<0x1::string::String>(v8, arg3);
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::sub_string(&arg1, 0, 0x1::string::length(&arg1)));
        let v9 = 0x2::display::new_with_fields<SilverPass>(arg0, v5, v7, arg5);
        0x2::display::update_version<SilverPass>(&mut v9);
        0x2::transfer::public_transfer<0x2::display::Display<SilverPass>>(v9, 0x2::tx_context::sender(arg5));
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"project_url"));
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = &mut v12;
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"Bronze Pass"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"Early access pass: BRONZE"));
        0x1::vector::push_back<0x1::string::String>(v13, arg4);
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::sub_string(&arg1, 0, 0x1::string::length(&arg1)));
        let v14 = 0x2::display::new_with_fields<BronzePass>(arg0, v10, v12, arg5);
        0x2::display::update_version<BronzePass>(&mut v14);
        0x2::transfer::public_transfer<0x2::display::Display<BronzePass>>(v14, 0x2::tx_context::sender(arg5));
    }

    public fun setup_transfer_policy_nft(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<Blub>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Blub>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Blub>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

