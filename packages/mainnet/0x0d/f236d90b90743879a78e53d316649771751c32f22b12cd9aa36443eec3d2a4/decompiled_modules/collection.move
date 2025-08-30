module 0xdf236d90b90743879a78e53d316649771751c32f22b12cd9aa36443eec3d2a4::collection {
    struct MyNft has store, key {
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

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    public entry fun airdrop_bronze(arg0: &Gate, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 312);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = BronzePass{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<BronzePass>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    public entry fun airdrop_gold(arg0: &Gate, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 310);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = GoldPass{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<GoldPass>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    public entry fun airdrop_silver(arg0: &Gate, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 311);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = SilverPass{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<SilverPass>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    public entry fun create_ticket(arg0: &Gate, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 300);
        let v0 = ArtTicket{
            id      : 0x2::object::new(arg2),
            blob_id : arg1,
            used    : false,
        };
        0x2::transfer::public_share_object<ArtTicket>(v0);
    }

    public entry fun create_tickets(arg0: &Gate, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 301);
        while (0x1::vector::length<0x1::string::String>(&arg1) > 0) {
            let v0 = ArtTicket{
                id      : 0x2::object::new(arg2),
                blob_id : 0x1::vector::pop_back<0x1::string::String>(&mut arg1),
                used    : false,
            };
            0x2::transfer::public_share_object<ArtTicket>(v0);
        };
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<COLLECTION>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun init_gate(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 100);
        assert!(arg5 < arg6 && arg6 < arg7, 101);
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
        0x2::transfer::public_share_object<Gate>(v0);
    }

    public entry fun mint_bronze(arg0: &mut Gate, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: BronzePass, arg3: &mut ArtTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.open_bronze_ms, 202);
        let BronzePass { id: v0 } = arg2;
        0x2::object::delete(v0);
        mint_common(arg0, arg1, arg3, 0x1::string::utf8(b"Bronze"), arg5);
    }

    fun mint_common(arg0: &mut Gate, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut ArtTicket, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted < arg0.supply, 220);
        assert!(!arg2.used, 221);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.price_mist, 222);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.admin);
        arg2.used = true;
        let v0 = 0x1::string::sub_string(&arg0.agg_base, 0, 0x1::string::length(&arg0.agg_base));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/v1/blobs/"));
        0x1::string::append(&mut v0, 0x1::string::sub_string(&arg2.blob_id, 0, 0x1::string::length(&arg2.blob_id)));
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Tier"), arg3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"BlobId"), 0x1::string::sub_string(&arg2.blob_id, 0, 0x1::string::length(&arg2.blob_id)));
        let v2 = MyNft{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::sub_string(&arg0.collection_name, 0, 0x1::string::length(&arg0.collection_name)),
            image_url   : v0,
            description : 0x1::string::sub_string(&arg0.description, 0, 0x1::string::length(&arg0.description)),
            attributes  : v1,
        };
        0x2::transfer::public_transfer<MyNft>(v2, 0x2::tx_context::sender(arg4));
        arg0.minted = arg0.minted + 1;
    }

    public entry fun mint_gold(arg0: &mut Gate, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: GoldPass, arg3: &mut ArtTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.open_gold_ms && v0 < arg0.open_silver_ms, 200);
        let GoldPass { id: v1 } = arg2;
        0x2::object::delete(v1);
        mint_common(arg0, arg1, arg3, 0x1::string::utf8(b"Gold"), arg5);
    }

    public entry fun mint_silver(arg0: &mut Gate, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: SilverPass, arg3: &mut ArtTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.open_silver_ms && v0 < arg0.open_bronze_ms, 201);
        let SilverPass { id: v1 } = arg2;
        0x2::object::delete(v1);
        mint_common(arg0, arg1, arg3, 0x1::string::utf8(b"Silver"), arg5);
    }

    // decompiled from Move bytecode v6
}

