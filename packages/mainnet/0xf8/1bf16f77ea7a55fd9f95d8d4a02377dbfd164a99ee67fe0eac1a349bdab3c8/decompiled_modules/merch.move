module 0xf81bf16f77ea7a55fd9f95d8d4a02377dbfd164a99ee67fe0eac1a349bdab3c8::merch {
    struct Merch has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        chip_pk: vector<u8>,
        image_url: 0x1::string::String,
        last_verify: u64,
    }

    struct MerchRegistry has key {
        id: 0x2::object::UID,
        items: 0x2::table::Table<vector<u8>, ItemDetails>,
    }

    struct ItemDetails has drop, store {
        merch_id: 0x1::option::Option<0x2::object::ID>,
        owner: 0x1::option::Option<address>,
        status: u8,
        title: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct PurchaseProof has key {
        id: 0x2::object::UID,
        item: Merch,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PurchaseProofMinted has copy, drop {
        purchase_proof_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct MerchActivated has copy, drop {
        merch_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct MerchListed has copy, drop {
        merch_id: 0x2::object::ID,
        owner: address,
    }

    struct MerchDelisted has copy, drop {
        merch_id: 0x2::object::ID,
        owner: address,
    }

    struct MerchBought has copy, drop {
        merch_id: 0x2::object::ID,
        buyer: address,
    }

    struct MerchBoughtFromEscrow has copy, drop {
        merch_id: 0x2::object::ID,
        buyer: address,
    }

    struct MERCH has drop {
        dummy_field: bool,
    }

    struct KExt has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MERCH>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"chip_pk"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"title"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"video_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{chip_pk}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{video_url}"));
        let v5 = 0x2::display::new_with_fields<Merch>(&v0, v1, v3, arg1);
        0x2::display::update_version<Merch>(&mut v5);
        let v6 = MerchRegistry{
            id    : 0x2::object::new(arg1),
            items : 0x2::table::new<vector<u8>, ItemDetails>(arg1),
        };
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<MerchRegistry>(v6);
        0x2::transfer::public_transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Merch>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun prove_physical_ownership(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(signature_verify(arg1, arg0, arg3, arg2, arg4), 2);
    }

    public fun signature_verify(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg3 + 300000 >= 0x2::clock::timestamp_ms(arg2), 1);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        0x2::ecdsa_k1::secp256k1_verify(&arg0, &arg1, &v1, 1)
    }

    // decompiled from Move bytecode v6
}

