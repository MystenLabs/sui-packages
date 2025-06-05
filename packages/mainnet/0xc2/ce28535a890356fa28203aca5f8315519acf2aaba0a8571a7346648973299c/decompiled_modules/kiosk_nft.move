module 0xc2ce28535a890356fa28203aca5f8315519acf2aaba0a8571a7346648973299c::kiosk_nft {
    struct KIOSK_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        mint_number: u64,
        rarity: 0x1::string::String,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        version: u64,
        mint_supply: u64,
        minted: u64,
        creator: address,
    }

    public fun create_collection(arg0: &0x2::package::Publisher, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id          : 0x2::object::new(arg2),
            version     : 1,
            mint_supply : arg1,
            minted      : 0,
            creator     : 0x2::tx_context::sender(arg2),
        }
    }

    public fun get_minted_count(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun get_royalty_fee_amount(arg0: &0x2::transfer_policy::TransferPolicy<Nft>, arg1: u64) : u64 {
        0xc2ce28535a890356fa28203aca5f8315519acf2aaba0a8571a7346648973299c::royalty_rule::fee_amount<Nft>(arg0, arg1)
    }

    fun init(arg0: KIOSK_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KIOSK_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::update_version<Nft>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<Nft>>(v1);
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0xc2ce28535a890356fa28203aca5f8315519acf2aaba0a8571a7346648973299c::personal_kiosk_rule::add<Nft>(&mut v5, &v4);
        0xc2ce28535a890356fa28203aca5f8315519acf2aaba0a8571a7346648973299c::kiosk_lock_rule::add<Nft>(&mut v5, &v4);
        0xc2ce28535a890356fa28203aca5f8315519acf2aaba0a8571a7346648973299c::royalty_rule::add<Nft>(&mut v5, &v4, 1000, 1000);
        0xc2ce28535a890356fa28203aca5f8315519acf2aaba0a8571a7346648973299c::witness_rule::add<Nft, Witness>(&mut v5, &v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : Nft {
        assert!(arg0.version == 1, 0);
        assert!(arg0.minted < arg0.mint_supply, 2);
        assert!(arg0.creator == 0x2::tx_context::sender(arg5), 3);
        arg0.minted = arg0.minted + 1;
        Nft{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            creator     : arg0.creator,
            mint_number : arg0.minted,
            rarity      : arg4,
        }
    }

    public fun pay_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &mut 0x2::transfer_policy::TransferRequest<Nft>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0xc2ce28535a890356fa28203aca5f8315519acf2aaba0a8571a7346648973299c::royalty_rule::pay<Nft>(arg0, arg1, arg2);
    }

    public fun prove_kiosk_lock_rule(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg2: &mut 0x2::transfer_policy::TransferRequest<Nft>) {
        0xc2ce28535a890356fa28203aca5f8315519acf2aaba0a8571a7346648973299c::kiosk_lock_rule::prove<Nft>(arg2, arg0);
    }

    public fun prove_personal_kiosk_rule(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg2: &mut 0x2::transfer_policy::TransferRequest<Nft>) {
        0xc2ce28535a890356fa28203aca5f8315519acf2aaba0a8571a7346648973299c::personal_kiosk_rule::prove<Nft>(arg0, arg2);
    }

    public fun prove_witness_rule(arg0: &0x2::transfer_policy::TransferPolicy<Nft>, arg1: &mut 0x2::transfer_policy::TransferRequest<Nft>) {
        let v0 = Witness{dummy_field: false};
        0xc2ce28535a890356fa28203aca5f8315519acf2aaba0a8571a7346648973299c::witness_rule::prove<Nft, Witness>(v0, arg0, arg1);
    }

    public fun update_mint_supply(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 3);
        assert!(arg0.minted <= arg1, 2);
        arg0.mint_supply = arg1;
    }

    // decompiled from Move bytecode v6
}

