module 0x3bffc6858d5866f6cd8bb5d26327ee4d41bb64c9e8fb589a0829a1b4cd5541b1::founding_predictor {
    struct FOUNDING_PREDICTOR has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        signer_pubkey: vector<u8>,
        minted: 0x2::table::Table<address, bool>,
        count: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct FoundingPredictor has key {
        id: 0x2::object::UID,
        number: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct Minted has copy, drop {
        who: address,
        number: u64,
        nft_id: 0x2::object::ID,
    }

    public fun configure(arg0: &mut Registry, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>) {
        arg0.signer_pubkey = arg2;
        arg0.image_url = 0x1::string::utf8(arg3);
    }

    public fun has_minted(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.minted, arg1)
    }

    fun init(arg0: FOUNDING_PREDICTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FOUNDING_PREDICTOR>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name} #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://predict.suidex.org"));
        let v5 = 0x2::display::new_with_fields<FoundingPredictor>(&v0, v1, v3, arg1);
        0x2::display::update_version<FoundingPredictor>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::display::Display<FoundingPredictor>>(v5, v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, v6);
        let v8 = Registry{
            id            : 0x2::object::new(arg1),
            signer_pubkey : b"",
            minted        : 0x2::table::new<address, bool>(arg1),
            count         : 0,
            name          : 0x1::string::utf8(b"Founding Predictor"),
            image_url     : 0x1::string::utf8(b""),
            description   : 0x1::string::utf8(b"A SuiDeX Predict Founding Predictor - an early backer of the World Cup pools. Rewards to follow."),
        };
        0x2::transfer::share_object<Registry>(v8);
    }

    public fun is_configured(arg0: &Registry) : bool {
        0x1::vector::length<u8>(&arg0.signer_pubkey) == 32
    }

    fun mint(arg0: &mut Registry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : FoundingPredictor {
        assert!(0x1::vector::length<u8>(&arg0.signer_pubkey) == 32, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.minted, v0), 2);
        let v1 = b"VICTORY_FOUNDING_MINT";
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&v0));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.signer_pubkey, &v1), 3);
        0x2::table::add<address, bool>(&mut arg0.minted, v0, true);
        arg0.count = arg0.count + 1;
        let v2 = arg0.count;
        let v3 = FoundingPredictor{
            id          : 0x2::object::new(arg2),
            number      : v2,
            name        : arg0.name,
            image_url   : arg0.image_url,
            description : arg0.description,
        };
        let v4 = Minted{
            who    : v0,
            number : v2,
            nft_id : 0x2::object::id<FoundingPredictor>(&v3),
        };
        0x2::event::emit<Minted>(v4);
        v3
    }

    public fun mint_to_sender(arg0: &mut Registry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2);
        0x2::transfer::transfer<FoundingPredictor>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun total_minted(arg0: &Registry) : u64 {
        arg0.count
    }

    // decompiled from Move bytecode v7
}

