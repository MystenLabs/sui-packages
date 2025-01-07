module 0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::early_contributor_pass {
    struct EARLY_CONTRIBUTOR_PASS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct EarlyContributorPass has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::attributes::Attributes,
    }

    struct MintedNftEvent has copy, drop {
        nftId: 0x2::object::ID,
        wallet_address: address,
    }

    struct BurnedNftEvent has copy, drop {
        nftId: 0x2::object::ID,
        wallet_address: address,
    }

    fun burn(arg0: EarlyContributorPass, arg1: &mut 0x2::tx_context::TxContext) {
        let EarlyContributorPass {
            id          : v0,
            name        : _,
            symbol      : _,
            description : _,
            image_url   : _,
            attributes  : _,
        } = arg0;
        let v6 = v0;
        let v7 = BurnedNftEvent{
            nftId          : 0x2::object::uid_to_inner(&v6),
            wallet_address : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<BurnedNftEvent>(v7);
        0x2::object::delete(v6);
    }

    public entry fun burn_nft(arg0: &0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::Version, arg1: EarlyContributorPass, arg2: &mut 0x2::tx_context::TxContext) {
        0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::assert_current_version(arg0);
        burn(arg1, arg2);
    }

    public entry fun burn_nft_from_kiosk(arg0: &0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::Version, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::assert_current_version(arg0);
        burn(0x2::kiosk::take<EarlyContributorPass>(arg2, arg3, arg1), arg4);
    }

    fun init(arg0: EARLY_CONTRIBUTOR_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<EARLY_CONTRIBUTOR_PASS>(arg0, arg1);
        0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::collection::display(&v0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"symbol"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{symbol}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://app.ensofi.xyz"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        let v5 = 0x2::display::new_with_fields<EarlyContributorPass>(&v0, v1, v3, arg1);
        0x2::display::update_version<EarlyContributorPass>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<EarlyContributorPass>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<EarlyContributorPass>(&mut v9, &v8, 400, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0xdfda63ad61f8ad5176c1107cb4a8377e3da14221221c3890d7f5a71a800dbbff);
        0x2::transfer::public_transfer<0x2::display::Display<EarlyContributorPass>>(v5, @0xdfda63ad61f8ad5176c1107cb4a8377e3da14221221c3890d7f5a71a800dbbff);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EarlyContributorPass>>(v8, @0xdfda63ad61f8ad5176c1107cb4a8377e3da14221221c3890d7f5a71a800dbbff);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EarlyContributorPass>>(v9);
        0x2::transfer::public_share_object<0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::collection::Collection>(0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::collection::new(arg1));
    }

    public(friend) fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : EarlyContributorPass {
        let v0 = EarlyContributorPass{
            id          : 0x2::object::new(arg7),
            name        : arg0,
            symbol      : arg1,
            description : arg2,
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            attributes  : 0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::attributes::new_from_vec(arg4, arg5),
        };
        let v1 = MintedNftEvent{
            nftId          : 0x2::object::id<EarlyContributorPass>(&v0),
            wallet_address : arg6,
        };
        0x2::event::emit<MintedNftEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

