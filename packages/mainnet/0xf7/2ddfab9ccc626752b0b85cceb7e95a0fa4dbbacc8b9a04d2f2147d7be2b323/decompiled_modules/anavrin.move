module 0xf72ddfab9ccc626752b0b85cceb7e95a0fa4dbbacc8b9a04d2f2147d7be2b323::anavrin {
    struct ANAVRIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Anavrin has store, key {
        id: 0x2::object::UID,
        birth_ms: u64,
        last_sync_ms: u64,
        evolution_stage: u8,
        base_mood: u8,
        base_form: u8,
        mutation_seed: u64,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        price: u64,
        mint_enabled: bool,
        treasury: address,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
    }

    struct MutationEvent has copy, drop {
        nft_id: 0x2::object::ID,
    }

    public fun current_traits(arg0: &Anavrin) : (u8, u8, u8) {
        (arg0.base_mood, arg0.base_form, arg0.evolution_stage)
    }

    fun init(arg0: ANAVRIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<ANAVRIN>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Anavrin"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"A living evolving creature on Sui"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://heart-beat-production.up.railway.app/nft/{id}.svg"));
        let v6 = 0x2::display::new_with_fields<Anavrin>(&v1, v2, v4, arg1);
        0x2::display::update_version<Anavrin>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Anavrin>>(v6, v0);
        let (v7, v8) = 0x2::transfer_policy::new<Anavrin>(&v1, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Anavrin>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Anavrin>>(v8, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        let v9 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v9, v0);
        let v10 = MintConfig{
            id           : 0x2::object::new(arg1),
            price        : 0,
            mint_enabled : true,
            treasury     : v0,
        };
        0x2::transfer::share_object<MintConfig>(v10);
    }

    public entry fun mint(arg0: &mut MintConfig, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_enabled, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.price, 1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.treasury);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::random::new_generator(arg2, arg4);
        let v2 = 0x2::random::generate_u64(&mut v1);
        let v3 = Anavrin{
            id              : 0x2::object::new(arg4),
            birth_ms        : v0,
            last_sync_ms    : v0,
            evolution_stage : 0,
            base_mood       : ((v2 % 4) as u8),
            base_form       : ((v2 / 4 % 4) as u8),
            mutation_seed   : v2,
        };
        let v4 = MintEvent{
            nft_id : 0x2::object::id<Anavrin>(&v3),
            owner  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MintEvent>(v4);
        0x2::transfer::public_transfer<Anavrin>(v3, 0x2::tx_context::sender(arg4));
    }

    public fun mutation_flags(arg0: &Anavrin) : u64 {
        arg0.mutation_seed
    }

    public entry fun set_enabled(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.mint_enabled = arg2;
    }

    public entry fun set_price(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.price = arg2;
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun species(arg0: &Anavrin) : u8 {
        ((arg0.mutation_seed % 4) as u8)
    }

    public entry fun sync(arg0: &mut Anavrin, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 - arg0.last_sync_ms > 30000) {
            arg0.last_sync_ms = v0;
            if (arg0.evolution_stage < 5) {
                arg0.evolution_stage = arg0.evolution_stage + 1;
            };
            let v1 = 0x2::random::new_generator(arg2, arg3);
            let v2 = 0x2::random::generate_u64(&mut v1);
            if (v2 % 100 == 0) {
                arg0.mutation_seed = arg0.mutation_seed ^ v2;
                let v3 = MutationEvent{nft_id: 0x2::object::id<Anavrin>(arg0)};
                0x2::event::emit<MutationEvent>(v3);
            };
        };
    }

    public entry fun update_display(arg0: &AdminCap, arg1: &mut 0x2::display::Display<Anavrin>, arg2: 0x1::string::String) {
        0x2::display::edit<Anavrin>(arg1, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display::update_version<Anavrin>(arg1);
    }

    // decompiled from Move bytecode v6
}

