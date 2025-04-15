module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::display {
    fun all_access_pass_collectible_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::all_access_pass_collectible::AllAccessPassCollectible> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"age_rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"sub_type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"royalty_percentage"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"season"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"artist"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Inspector Gadget's Classic Comeback"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/1725913637405Unlock_1.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Stay tuned as the Gamisodes Inspector Gadget story unfolds - currently at unlock Level 1!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.gamisodes.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Inspector Gadget"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TV-Y7"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Collectible"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Trading Card"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Reveal"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"1"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"1"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bayu Sadewo"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Limited"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a920323032342047616d69736f64657320262057696c64427261696e2e2022496e73706563746f72204761646765742028436c6173736963292220636f757274657379206f6620444858204d656469612028546f726f6e746f29204c74642e202d4652332d204669656c6420436f6d6d756e69636174696f6e2e20416c6c207269676874732072657365727665642e"));
        let v4 = 0x2::display::new_with_fields<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::all_access_pass_collectible::AllAccessPassCollectible>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::all_access_pass_collectible::AllAccessPassCollectible>(&mut v4);
        v4
    }

    fun all_access_pass_token_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::all_access_pass_token::AllAccessPassToken> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"primary_image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"age_rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"royalty"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"treasury_wallet"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"activation_date"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"expiration_date"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rank"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes Inspector Gadget Episode Gameplay Subscription Card"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/1725917908511Subscription_Card_1_-_12_Months_Display.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/1725917795531Subscription_Card_1_-_12_Months_Product.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The Limited Edition Gamisodes Inspector Gadget Episode Gameplay Subscription Card. Level 1 unlocked with 12 months of access!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.gamisodes.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Inspector Gadget"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TV-Y7"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Subscription"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Card"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5%"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"0x4d00b128a5102baee93d6f0ee4b016f2580cc134542e7a6da7f388d2007b579d"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"January 1, 2025"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"December 31, 2025"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"1"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"1"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Limited"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a920323032342047616d69736f64657320262057696c64427261696e2e2022496e73706563746f72204761646765742028436c6173736963292220636f757274657379206f6620444858204d656469612028546f726f6e746f29204c74642e202d4652332d204669656c6420436f6d6d756e69636174696f6e2e20416c6c207269676874732072657365727665642e"));
        let v4 = 0x2::display::new_with_fields<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::all_access_pass_token::AllAccessPassToken>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::all_access_pass_token::AllAccessPassToken>(&mut v4);
        v4
    }

    fun gadget_xp_community_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_xps::Community>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"age_rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gadget Community XPs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/1725905707202Gadget_Community_XP.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gadget Community XP is earned by participating in the Inspector Gadget community, helping you unlock roles and perks based on your engagement."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.gamisodes.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TV-Y7"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Inspector Gadget"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Experience Point"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a920323032342047616d69736f64657320262057696c64427261696e2e2022496e73706563746f72204761646765742028436c6173736963292220636f757274657379206f6620444858204d656469612028546f726f6e746f29204c74642e202d4652332d204669656c6420436f6d6d756e69636174696f6e2e20416c6c207269676874732072657365727665642e"));
        let v4 = 0x2::display::new_with_fields<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_xps::Community>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_xps::Community>>(&mut v4);
        v4
    }

    fun gadget_xp_gameplay_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_xps::Gameplay>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"age_rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gadget Gameplay XPs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/1725905755905Gadget_Gameplay_XP.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gadget Gameplay XP is earned by playing Inspector Gadget, allowing you to unlock roles and perks as you level up."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.gamisodes.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TV-Y7"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Inspector Gadget"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Experience Point"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a920323032342047616d69736f64657320262057696c64427261696e2e2022496e73706563746f72204761646765742028436c6173736963292220636f757274657379206f6620444858204d656469612028546f726f6e746f29204c74642e202d4652332d204669656c6420436f6d6d756e69636174696f6e2e20416c6c207269676874732072657365727665642e"));
        let v4 = 0x2::display::new_with_fields<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_xps::Gameplay>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_xps::Gameplay>>(&mut v4);
        v4
    }

    fun hayden_michael_portrait_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::Portrait<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::HaydenMichael>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"sub_type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"royalty"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"treasury_address"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Artist"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"age_rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Hayden EYEdentified Portrait"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/EYEdentified_Portrait_HAYDEN.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"LA Com-EYE-con Guy"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.gamisodes.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"EYEdentity"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Collectible"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Portrait"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"EYEdentified"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5%"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"0xb73f130f70ce3fda909699b2978da240d73d1c6c85a2ef3624819b42641bd681"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"John Doze"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a920323032342045594564656e74697479"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TV-MA"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Limited"));
        let v4 = 0x2::display::new_with_fields<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::Portrait<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::HaydenMichael>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::Portrait<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::HaydenMichael>>(&mut v4);
        v4
    }

    fun klaus_mueller_portrait_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::Portrait<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::KlausMueller>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"sub_type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"royalty"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"treasury_address"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Artist"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"age_rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Klaus EYEdentified Portrait"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/EYEdentified_Portrait_KLAUS.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"EYE-dea Man"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.gamisodes.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"EYEdentity"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Collectible"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Portrait"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"EYEdentified"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5%"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"0xb73f130f70ce3fda909699b2978da240d73d1c6c85a2ef3624819b42641bd681"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"John Doze"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a920323032342045594564656e74697479"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TV-MA"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Limited"));
        let v4 = 0x2::display::new_with_fields<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::Portrait<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::KlausMueller>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::Portrait<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::KlausMueller>>(&mut v4);
        v4
    }

    public(friend) fun setup_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter::Counter>(arg0), 0);
        let v0 = stashed_airdrop_display(arg0, arg1);
        let v1 = xp_community_display(arg0, arg1);
        let v2 = xp_gameplay_display(arg0, arg1);
        let v3 = gadget_xp_community_display(arg0, arg1);
        let v4 = gadget_xp_gameplay_display(arg0, arg1);
        let v5 = all_access_pass_collectible_display(arg0, arg1);
        let v6 = all_access_pass_token_display(arg0, arg1);
        let v7 = klaus_mueller_portrait_display(arg0, arg1);
        let v8 = hayden_michael_portrait_display(arg0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::Portrait<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::KlausMueller>>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::Portrait<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::eyedentity_portraits::HaydenMichael>>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::stashed_airdrop::Airdrop>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xps::Community>>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xps::Gameplay>>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_xps::Community>>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_xps::Gameplay>>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::all_access_pass_collectible::AllAccessPassCollectible>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::all_access_pass_token::AllAccessPassToken>>(v6, 0x2::tx_context::sender(arg1));
    }

    fun stashed_airdrop_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::stashed_airdrop::Airdrop> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"sub_type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes + Stashed"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/1725888232367Stashed_Gamisodes.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Congratulations on successfully connecting your Stashed wallet with Gamisodes!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.gamisodes.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Collectible"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Trading Card"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Partnership"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a920323032342047616d69736f6465732026204d797374656e204c6162732e20416c6c207269676874732072657365727665642e"));
        let v4 = 0x2::display::new_with_fields<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::stashed_airdrop::Airdrop>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::stashed_airdrop::Airdrop>(&mut v4);
        v4
    }

    fun xp_community_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xps::Community>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes Community XPs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/1725887269322Gamisodes_Community_XP.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes Community XP are earned by actively engaging in the Gamisodes community, unlocking roles and perks tailored to your level of involvement."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.gamisodes.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Experience Point"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a920323032342047616d69736f6465732e20416c6c207269676874732072657365727665642e"));
        let v4 = 0x2::display::new_with_fields<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xps::Community>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xps::Community>>(&mut v4);
        v4
    }

    fun xp_gameplay_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xps::Gameplay>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes Gameplay XPs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/1725887152152Gamisodes_Gameplay_XP.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes Gameplay XP are earned by playing on the platform, unlocking exclusive roles and perks as you progress."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.gamisodes.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gamisodes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Experience Point"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a920323032342047616d69736f6465732e20416c6c207269676874732072657365727665642e"));
        let v4 = 0x2::display::new_with_fields<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xps::Gameplay>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xp_helpers::XP<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::xps::Gameplay>>(&mut v4);
        v4
    }

    // decompiled from Move bytecode v6
}

