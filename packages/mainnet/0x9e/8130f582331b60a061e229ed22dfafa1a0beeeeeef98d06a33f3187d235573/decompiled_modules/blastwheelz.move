module 0x9e8130f582331b60a061e229ed22dfafa1a0beeeeeef98d06a33f3187d235573::blastwheelz {
    struct BLASTWHEELZ has drop {
        dummy_field: bool,
    }

    struct Mustang has drop {
        dummy_field: bool,
    }

    struct NFT<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        mint_number: u64,
        alloy_rim: 0x1::string::String,
        front_bonnet: 0x1::string::String,
        back_bonnet: 0x1::string::String,
        creator: address,
    }

    struct Collection<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_supply: u64,
        minted: u64,
        creator: address,
    }

    public fun create_collection<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection<T0>{
            id          : 0x2::object::new(arg1),
            mint_supply : arg0,
            minted      : 0,
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<Collection<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::new(arg0)
    }

    public fun get_minted_count<T0>(arg0: &Collection<T0>) : u64 {
        arg0.minted
    }

    fun init(arg0: BLASTWHEELZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BLASTWHEELZ>(arg0, arg1);
        let v1 = 0x2::display::new<NFT<Mustang>>(&v0, arg1);
        0x2::display::add<NFT<Mustang>>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<NFT<Mustang>>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<NFT<Mustang>>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"{project_url}"));
        0x2::display::add<NFT<Mustang>>(&mut v1, 0x1::string::utf8(b"alloy_rim"), 0x1::string::utf8(b"{alloy_rim}"));
        0x2::display::add<NFT<Mustang>>(&mut v1, 0x1::string::utf8(b"front_bonnet"), 0x1::string::utf8(b"{front_bonnet}"));
        0x2::display::add<NFT<Mustang>>(&mut v1, 0x1::string::utf8(b"back_bonnet"), 0x1::string::utf8(b"{back_bonnet}"));
        0x2::display::add<NFT<Mustang>>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::update_version<NFT<Mustang>>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<NFT<Mustang>>>(v1);
        setup_transfer_policy_for_type<Mustang>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint<T0>(arg0: &mut Collection<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<NFT<T0>>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::KioskOwnerCap {
        assert!(arg0.minted < arg0.mint_supply, 1);
        arg0.minted = arg0.minted + 1;
        let v0 = NFT<T0>{
            id           : 0x2::object::new(arg8),
            name         : arg2,
            image_url    : arg3,
            project_url  : arg4,
            mint_number  : arg0.minted,
            alloy_rim    : arg5,
            front_bonnet : arg6,
            back_bonnet  : arg7,
            creator      : arg0.creator,
        };
        let (v1, v2) = 0x2::kiosk::new(arg8);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<NFT<T0>>(&mut v4, &v3, arg1, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        v3
    }

    public fun setup_transfer_policy<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<NFT<T0>>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x9e8130f582331b60a061e229ed22dfafa1a0beeeeeef98d06a33f3187d235573::rules::add_personal_kiosk_rule<NFT<T0>>(&mut v3, &v2);
        0x9e8130f582331b60a061e229ed22dfafa1a0beeeeeef98d06a33f3187d235573::rules::add_kiosk_lock_rule<NFT<T0>>(&mut v3, &v2);
        0x9e8130f582331b60a061e229ed22dfafa1a0beeeeeef98d06a33f3187d235573::rules::add_royalty_rule<NFT<T0>>(&mut v3, &v2, 0x9e8130f582331b60a061e229ed22dfafa1a0beeeeeef98d06a33f3187d235573::rules::new_royalty_config(500, 0));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT<T0>>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT<T0>>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun setup_transfer_policy_for_type<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<NFT<T0>>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x9e8130f582331b60a061e229ed22dfafa1a0beeeeeef98d06a33f3187d235573::rules::add_personal_kiosk_rule<NFT<T0>>(&mut v3, &v2);
        0x9e8130f582331b60a061e229ed22dfafa1a0beeeeeef98d06a33f3187d235573::rules::add_kiosk_lock_rule<NFT<T0>>(&mut v3, &v2);
        0x9e8130f582331b60a061e229ed22dfafa1a0beeeeeef98d06a33f3187d235573::rules::add_royalty_rule<NFT<T0>>(&mut v3, &v2, 0x9e8130f582331b60a061e229ed22dfafa1a0beeeeeef98d06a33f3187d235573::rules::new_royalty_config(500, 0));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT<T0>>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT<T0>>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun update_mint_supply<T0>(arg0: &mut Collection<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        assert!(arg0.minted <= arg1, 1);
        arg0.mint_supply = arg1;
    }

    public fun update_nft<T0>(arg0: &mut NFT<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        arg0.name = arg1;
        arg0.image_url = arg2;
        arg0.project_url = arg3;
        arg0.alloy_rim = arg4;
        arg0.front_bonnet = arg5;
        arg0.back_bonnet = arg6;
    }

    // decompiled from Move bytecode v6
}

