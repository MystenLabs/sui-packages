module 0x2f38264833106aff198970b7521a1ee8e1ef299defbff6f6746ddc5186b40708::kiosk_nft {
    struct KIOSK_NFT has drop {
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
        attributes: 0x2f38264833106aff198970b7521a1ee8e1ef299defbff6f6746ddc5186b40708::attributes::Attributes,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        version: u64,
        mint_supply: u64,
        minted: u64,
        creator: address,
    }

    public fun get_attributes_data(arg0: &Nft) : 0x2f38264833106aff198970b7521a1ee8e1ef299defbff6f6746ddc5186b40708::attributes::AttributesData {
        0x2f38264833106aff198970b7521a1ee8e1ef299defbff6f6746ddc5186b40708::attributes::get_attributes_data(&arg0.attributes)
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

    public fun get_attributes(arg0: &Nft) : &0x2f38264833106aff198970b7521a1ee8e1ef299defbff6f6746ddc5186b40708::attributes::Attributes {
        &arg0.attributes
    }

    public fun get_minted_count(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun get_royalty_fee_amount(arg0: &0x2::transfer_policy::TransferPolicy<Nft>, arg1: u64) : u64 {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<Nft>(arg0, arg1)
    }

    fun init(arg0: KIOSK_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KIOSK_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Nft>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<Nft>>(v1);
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<Nft>(&mut v5, &v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Nft>(&mut v5, &v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 1000, 1000);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2f38264833106aff198970b7521a1ee8e1ef299defbff6f6746ddc5186b40708::attributes::CreateAttributesCap, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: &mut 0x2::tx_context::TxContext) : Nft {
        assert!(arg0.version == 1, 0);
        assert!(arg0.minted < arg0.mint_supply, 2);
        assert!(arg0.creator == 0x2::tx_context::sender(arg16), 3);
        arg0.minted = arg0.minted + 1;
        Nft{
            id          : 0x2::object::new(arg16),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            creator     : arg0.creator,
            mint_number : arg0.minted,
            rarity      : arg4,
            attributes  : 0x2f38264833106aff198970b7521a1ee8e1ef299defbff6f6746ddc5186b40708::attributes::new(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16),
        }
    }

    public fun pay_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg1: &mut 0x2::transfer_policy::TransferRequest<Nft>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<Nft>(arg0, arg1, arg2);
    }

    public fun prove_kiosk_lock_rule(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg2: &mut 0x2::transfer_policy::TransferRequest<Nft>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<Nft>(arg2, arg0);
    }

    public fun prove_personal_kiosk_rule(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg2: &mut 0x2::transfer_policy::TransferRequest<Nft>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<Nft>(arg0, arg2);
    }

    public fun update_mint_supply(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 3);
        assert!(arg0.minted <= arg1, 2);
        arg0.mint_supply = arg1;
    }

    // decompiled from Move bytecode v6
}

