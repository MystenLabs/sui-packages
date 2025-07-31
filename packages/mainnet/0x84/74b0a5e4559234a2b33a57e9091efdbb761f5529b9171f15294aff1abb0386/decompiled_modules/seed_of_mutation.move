module 0x8474b0a5e4559234a2b33a57e9091efdbb761f5529b9171f15294aff1abb0386::seed_of_mutation {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintingInfo has key {
        id: 0x2::object::UID,
        supply: u64,
        max_supply: u64,
    }

    struct SeedOfMutation has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        item_type: 0x1::string::String,
    }

    struct SeedMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        recipient: address,
        supply: u64,
    }

    struct SEED_OF_MUTATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEED_OF_MUTATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MintingInfo{
            id         : 0x2::object::new(arg1),
            supply     : 0,
            max_supply : 15,
        };
        0x2::transfer::share_object<MintingInfo>(v1);
        let v2 = 0x2::package::claim<SEED_OF_MUTATION>(arg0, arg1);
        let v3 = 0x2::display::new<SeedOfMutation>(&v2, arg1);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"item_type"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{item_type}"));
        0x2::display::add_multiple<SeedOfMutation>(&mut v3, v4, v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::display::Display<SeedOfMutation>>(v3);
    }

    public entry fun mint_to_recipient(arg0: &AdminCap, arg1: &mut MintingInfo, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.supply < arg1.max_supply, 0);
        arg1.supply = arg1.supply + 1;
        let v0 = SeedOfMutation{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"Seed of Mutation"),
            description : 0x1::string::utf8(b"A mysterious seed that hums with unstable energy. Holding it increases the chance of encountering mutated Mystemons."),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://aggregator.mainnet.walrus.mirai.cloud/v1/blobs/UTpZULsc-ux65TAZeuosGt-3HFO6eeTQCrBJ1rRufD0"),
            item_type   : 0x1::string::utf8(b"Equippable Item"),
        };
        let v1 = SeedMinted{
            object_id : 0x2::object::id<SeedOfMutation>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            recipient : arg2,
            supply    : arg1.supply,
        };
        0x2::event::emit<SeedMinted>(v1);
        0x2::transfer::public_transfer<SeedOfMutation>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

