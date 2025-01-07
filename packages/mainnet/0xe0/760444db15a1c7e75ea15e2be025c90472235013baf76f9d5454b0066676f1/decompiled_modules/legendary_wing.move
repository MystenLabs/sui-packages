module 0xe0760444db15a1c7e75ea15e2be025c90472235013baf76f9d5454b0066676f1::legendary_wing {
    struct Wing has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        durability: u8,
        speed: u8,
        sharpness: u8,
    }

    struct WingRegistry has key {
        id: 0x2::object::UID,
        total_supply: u64,
        count: u64,
        total_claim_supply: u64,
        claim_count: u64,
        token_id: u64,
        registry: 0x2::table::Table<address, bool>,
    }

    struct EventMint has copy, drop {
        receiver: address,
        token_id: u64,
        durability: u8,
        speed: u8,
        sharpness: u8,
    }

    struct EventClaimWithSignature has copy, drop {
        receiver: address,
        token_id: u64,
        durability: u8,
        speed: u8,
        sharpness: u8,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PublicKey has key {
        id: 0x2::object::UID,
        pk: vector<u8>,
    }

    struct LEGENDARY_WING has drop {
        dummy_field: bool,
    }

    public entry fun claimWithSignature(arg0: &mut WingRegistry, arg1: &PublicKey, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.count <= arg0.total_supply, 1);
        assert!(arg0.claim_count <= arg0.total_claim_supply, 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.registry, arg3), 0);
        let v0 = 0x2::address::to_string(arg3);
        0x1::string::append_utf8(&mut v0, b"Legendary");
        let v1 = 0x2::hash::blake2b256(0x1::string::bytes(&v0));
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg1.pk, &v1) == true, 0);
        0x2::table::add<address, bool>(&mut arg0.registry, arg3, true);
        arg0.token_id = arg0.token_id + 1;
        arg0.claim_count = arg0.claim_count + 1;
        arg0.count = arg0.count + 1;
        0x2::transfer::transfer<Wing>(mint_nft(arg0.token_id, arg3, 1, arg4), arg3);
    }

    public entry fun create_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    fun gen_random(arg0: vector<u8>, arg1: u8, arg2: u8) : u8 {
        let v0 = 0x1::hash::sha3_256(arg0);
        let v1 = 0x2::bcs::new(0x1::hash::sha3_256(v0));
        let v2 = ((safe_add_u64(0x2::bcs::peel_u8(&mut v1), arg1) % (arg2 as u16)) as u8);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&v2));
        let v3 = 0x2::bcs::new(0x1::hash::sha3_256(v0));
        ((safe_add_u64(0x2::bcs::peel_u8(&mut v3), arg1) % (arg2 as u16)) as u8)
    }

    public entry fun getPublicKey(arg0: &PublicKey) : vector<u8> {
        arg0.pk
    }

    public fun get_next_token_id(arg0: &WingRegistry) : u64 {
        arg0.token_id + 1
    }

    public fun get_supply(arg0: &WingRegistry) : (u64, u64, u64, u64) {
        (arg0.total_supply, arg0.count, arg0.total_claim_supply, arg0.claim_count)
    }

    public fun get_wing_attributes(arg0: &Wing) : (u8, u8, u8) {
        (arg0.durability, arg0.speed, arg0.sharpness)
    }

    fun init(arg0: LEGENDARY_WING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Legendary Explorer's Wing #{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.cubicgames.xyz/games"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cubic-static.s3.amazonaws.com/common/bbp/n7.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"An even bigger reward awaits those ultimate Steam players who explore Web3."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.cubicgames.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cubic Creator"));
        let v4 = 0x2::package::claim<LEGENDARY_WING>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Wing>(&v4, v0, v2, arg1);
        0x2::display::update_version<Wing>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Wing>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = WingRegistry{
            id                 : 0x2::object::new(arg1),
            total_supply       : 200,
            count              : 0,
            total_claim_supply : 80,
            claim_count        : 0,
            token_id           : 0,
            registry           : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<WingRegistry>(v7);
        let v8 = PublicKey{
            id : 0x2::object::new(arg1),
            pk : b"0x",
        };
        0x2::transfer::share_object<PublicKey>(v8);
    }

    public entry fun mint(arg0: &AdminCap, arg1: &mut WingRegistry, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.count + arg2 <= arg1.total_supply, 1);
        let v0 = 0;
        while (v0 < arg2) {
            arg1.token_id = arg1.token_id + 1;
            arg1.count = arg1.count + 1;
            0x2::transfer::transfer<Wing>(mint_nft(arg1.token_id, arg3, 0, arg4), arg3);
            v0 = v0 + 1;
        };
    }

    fun mint_nft(arg0: u64, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : Wing {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = 85 + gen_random(v1, 0, 15);
        let v3 = 85 + gen_random(v1, v2, 15);
        let v4 = 85 + gen_random(v1, v3, 15);
        let v5 = Wing{
            id         : v0,
            token_id   : arg0,
            durability : v2,
            speed      : v3,
            sharpness  : v4,
        };
        if (arg2 == 0) {
            let v6 = EventMint{
                receiver   : arg1,
                token_id   : arg0,
                durability : v2,
                speed      : v3,
                sharpness  : v4,
            };
            0x2::event::emit<EventMint>(v6);
        } else if (arg2 == 1) {
            let v7 = EventClaimWithSignature{
                receiver   : arg1,
                token_id   : arg0,
                durability : v2,
                speed      : v3,
                sharpness  : v4,
            };
            0x2::event::emit<EventClaimWithSignature>(v7);
        };
        v5
    }

    public fun safe_add_u64(arg0: u8, arg1: u8) : u16 {
        (arg0 as u16) + (arg1 as u16)
    }

    public entry fun setPublicKey(arg0: &AdminCap, arg1: &mut PublicKey, arg2: vector<u8>) {
        arg1.pk = arg2;
    }

    // decompiled from Move bytecode v6
}

