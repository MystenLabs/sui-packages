module 0x7bf5a2f97d3f3793b36b58d7dbee648916e7ac062ba910f6f66301b3b592d727::suigoose {
    struct SUIGOOSE has drop {
        dummy_field: bool,
    }

    struct EggFragment has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        fragment_id: u8,
    }

    struct Egg has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        fragments_collected: u8,
    }

    struct CouncilData has key {
        id: 0x2::object::UID,
        house: address,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        fixed_fee: u64,
        base_fee_in_bp: u16,
    }

    struct DisplayCap has key {
        id: 0x2::object::UID,
    }

    struct CouncilCap has key {
        id: 0x2::object::UID,
    }

    struct EggFragmentMinted has copy, drop {
        egg_fragment_id: 0x2::object::ID,
        fragment_id: u8,
    }

    struct EggReconstructed has copy, drop {
        egg_id: 0x2::object::ID,
    }

    public entry fun burn_egg(arg0: Egg, arg1: &mut CouncilData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > arg1.fixed_fee, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let Egg {
            id                  : v0,
            name                : _,
            description         : _,
            url                 : _,
            fragments_collected : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun burn_egg_fragment(arg0: EggFragment, arg1: &mut CouncilData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > arg1.fixed_fee, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let EggFragment {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            fragment_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun claim_fees(arg0: &mut CouncilData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == council_house(arg0), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fees, council_fees(arg0), arg1), council_house(arg0));
    }

    public fun council_fees(arg0: &CouncilData) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fees)
    }

    public fun council_house(arg0: &CouncilData) : address {
        arg0.house
    }

    public fun create_display(arg0: 0x2::package::Publisher, arg1: DisplayCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"fragment_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{fragment_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigoose.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SUI GOOSE"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"fragments_collected"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"creator"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{fragments_collected}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://suigoose.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"SUI GOOSE"));
        let v8 = 0x2::display::new_with_fields<EggFragment>(&arg0, v0, v2, arg2);
        0x2::display::update_version<EggFragment>(&mut v8);
        let v9 = 0x2::display::new_with_fields<Egg>(&arg0, v4, v6, arg2);
        0x2::display::update_version<Egg>(&mut v9);
        let DisplayCap { id: v10 } = arg1;
        0x2::object::delete(v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(arg0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::display::Display<EggFragment>>(v8, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::display::Display<Egg>>(v9, 0x2::tx_context::sender(arg2));
    }

    public fun egg_fragment_fragment_id(arg0: &EggFragment) : u8 {
        arg0.fragment_id
    }

    public fun egg_fragment_id(arg0: &EggFragment) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun egg_fragments_collected(arg0: &Egg) : u8 {
        arg0.fragments_collected
    }

    public fun egg_id(arg0: &Egg) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: SUIGOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SUIGOOSE>(arg0, arg1);
        let v0 = DisplayCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DisplayCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = CouncilCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CouncilCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_council_data(arg0: CouncilCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0);
        let v0 = CouncilData{
            id             : 0x2::object::new(arg2),
            house          : 0x2::tx_context::sender(arg2),
            fees           : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            fixed_fee      : 1000000,
            base_fee_in_bp : 100,
        };
        let CouncilCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::transfer<CouncilData>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_custom_egg_to_sender(arg0: u8, arg1: &mut CouncilData, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == council_house(arg1), 2);
        assert!(arg0 >= 1 && arg0 <= 50, 1);
        let v0 = Egg{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"Reconstructed Egg"),
            description         : 0x1::string::utf8(b"This egg is reconstructed when you collect 50 fragments. Sui Goose (https://raidenx.io/sui/movepump-goose-sui-252730?ref=suigoose) (GOOSE) 0x901399bdfba097a413631cbc1ec848612d23af3890daf29d6822b43d287bc96a::goose::GOOSE"),
            url                 : 0x2::url::new_unsafe_from_bytes(b"https://moccasin-secondary-mole-253.mypinata.cloud/ipfs/bafybeicq3erj5nlxnbhum5wj2xhuxhvlbgefbfa5awpgvafwykjf3u6iue"),
            fragments_collected : arg0,
        };
        let v1 = EggReconstructed{egg_id: 0x2::object::id<Egg>(&v0)};
        0x2::event::emit<EggReconstructed>(v1);
        transfer_egg_to_sender(v0, arg2);
    }

    public(friend) fun mint_egg(arg0: &mut CouncilData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : Egg {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > arg0.fixed_fee, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = Egg{
            id                  : 0x2::object::new(arg2),
            name                : 0x1::string::utf8(b"Reconstructed Egg"),
            description         : 0x1::string::utf8(b"This egg is reconstructed when you collect 50 fragments. Sui Goose (https://raidenx.io/sui/movepump-goose-sui-252730?ref=suigoose) (GOOSE) 0x901399bdfba097a413631cbc1ec848612d23af3890daf29d6822b43d287bc96a::goose::GOOSE"),
            url                 : 0x2::url::new_unsafe_from_bytes(b"https://moccasin-secondary-mole-253.mypinata.cloud/ipfs/bafybeicq3erj5nlxnbhum5wj2xhuxhvlbgefbfa5awpgvafwykjf3u6iue"),
            fragments_collected : 0,
        };
        let v1 = EggReconstructed{egg_id: 0x2::object::id<Egg>(&v0)};
        0x2::event::emit<EggReconstructed>(v1);
        v0
    }

    public(friend) fun mint_egg_fragment(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : EggFragment {
        assert!(arg0 >= 1 && arg0 <= 50, 1);
        let v0 = 0x1::string::utf8(b"Egg Fragment #");
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg0));
        let v1 = 0x1::string::utf8(b"Sui Goose (GOOSE) 0x901399bdfba097a413631cbc1ec848612d23af3890daf29d6822b43d287bc96a::goose::GOOSE (https://raidenx.io/sui/movepump-goose-sui-252730?ref=suigoose) This fragment will help you to reconstruct the egg. Egg Fragment Id #");
        0x1::string::append(&mut v1, 0x1::u8::to_string(arg0));
        EggFragment{
            id          : 0x2::object::new(arg1),
            name        : v0,
            description : v1,
            url         : 0x2::url::new_unsafe_from_bytes(b"https://moccasin-secondary-mole-253.mypinata.cloud/ipfs/bafybeihl2s6e3unp5j6tbzfeednmocrw5grw67bzqd7mo45skyu6qbi5t4"),
            fragment_id : arg0,
        }
    }

    public entry fun mint_egg_fragment_to_sender(arg0: u8, arg1: &mut CouncilData, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == council_house(arg1), 2);
        assert!(arg0 >= 1 && arg0 <= 50, 1);
        let v0 = mint_egg_fragment(arg0, arg2);
        let v1 = EggFragmentMinted{
            egg_fragment_id : 0x2::object::id<EggFragment>(&v0),
            fragment_id     : arg0,
        };
        0x2::event::emit<EggFragmentMinted>(v1);
        transfer_egg_fragment_to_sender(v0, arg2);
    }

    public entry fun mint_egg_to_sender(arg0: &mut CouncilData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_egg(arg0, arg1, arg2);
        transfer_egg_to_sender(v0, arg2);
    }

    public fun transfer_egg_fragment_to_sender(arg0: EggFragment, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<EggFragment>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_egg_to_sender(arg0: Egg, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Egg>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

