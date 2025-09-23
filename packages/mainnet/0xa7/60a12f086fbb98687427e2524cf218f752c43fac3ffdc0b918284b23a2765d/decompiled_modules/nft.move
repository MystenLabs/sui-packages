module 0xa760a12f086fbb98687427e2524cf218f752c43fac3ffdc0b918284b23a2765d::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        mint_count: u64,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct Attributes has drop, store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: vector<Attributes>,
        rarity: u64,
    }

    struct MintNftEvent has copy, drop {
        nft_id: 0x2::object::ID,
    }

    fun assert_mintable(arg0: &Config) {
        assert!(arg0.mint_count < arg0.max_supply, 0);
    }

    public fun create_nft(arg0: &MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: u64, arg7: &mut Config, arg8: &mut 0x2::tx_context::TxContext) : Nft {
        assert_mintable(arg7);
        let v0 = impl_mint(arg1, arg3, arg2, arg6, arg4, arg5, arg8);
        let v1 = MintNftEvent{nft_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<MintNftEvent>(v1);
        arg7.mint_count = arg7.mint_count + 1;
        v0
    }

    fun impl_mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) : Nft {
        let v0 = 0x1::vector::empty<Attributes>();
        0x1::vector::reverse<0x1::string::String>(&mut arg5);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 13906834805703573503);
        0x1::vector::reverse<0x1::string::String>(&mut arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            let v2 = Attributes{
                key   : 0x1::vector::pop_back<0x1::string::String>(&mut arg4),
                value : 0x1::vector::pop_back<0x1::string::String>(&mut arg5),
            };
            0x1::vector::push_back<Attributes>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg4);
        0x1::vector::destroy_empty<0x1::string::String>(arg5);
        Nft{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            image_url   : arg1,
            description : arg2,
            attributes  : v0,
            rarity      : arg3,
        }
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        setup_display(0x2::display::new<Nft>(&v0, arg1), v1);
        setup_rules(v2, v3, v1);
        let v4 = Config{
            id         : 0x2::object::new(arg1),
            max_supply : 3000,
            mint_count : 0,
        };
        0x2::transfer::share_object<Config>(v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        let v5 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MintCap>(v5, v1);
    }

    public fun launchpad_mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &0x2::transfer_policy::TransferPolicy<Nft>, arg9: &mut 0x71296655b5bf15a4115573ccc283e1b75974a338e639a125adffcaf7560b16f::launch_manager::Launch, arg10: &mut 0x71296655b5bf15a4115573ccc283e1b75974a338e639a125adffcaf7560b16f::launchpad::Launchpad, arg11: u64, arg12: &mut Config, arg13: &mut 0x2::tx_context::TxContext) {
        assert_mintable(arg12);
        let v0 = impl_mint(arg0, arg2, arg1, arg11, arg4, arg5, arg13);
        let v1 = MintNftEvent{nft_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<MintNftEvent>(v1);
        arg12.mint_count = arg12.mint_count + 1;
        0x71296655b5bf15a4115573ccc283e1b75974a338e639a125adffcaf7560b16f::launch_manager::mint_with_kiosk<Nft>(arg9, v0, arg6, arg8, arg7, arg3, arg10, arg13);
    }

    public fun max_supply(arg0: &Config) : u64 {
        arg0.max_supply
    }

    public fun mint_count(arg0: &Config) : u64 {
        arg0.mint_count
    }

    fun setup_display(arg0: 0x2::display::Display<Nft>, arg1: address) {
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Nft"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"Nft is a collection of unique NFTs representing digital collectibles."));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://testers.com"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Nft Team"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"banner_image"), 0x1::string::utf8(b"https://testers.com/banner.png"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"cover_url"), 0x1::string::utf8(b"https://testers.com/cover.png"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut arg0, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::update_version<Nft>(&mut arg0);
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(arg0, arg1);
    }

    fun setup_rules(arg0: 0x2::transfer_policy::TransferPolicy<Nft>, arg1: 0x2::transfer_policy::TransferPolicyCap<Nft>, arg2: address) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut arg0, &arg1, 200, 100000000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Nft>(&mut arg0, &arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(arg1, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(arg0);
    }

    // decompiled from Move bytecode v6
}

