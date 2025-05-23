module 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::nft {
    struct Tako has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_hash: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct NewTakoMinted has copy, drop {
        id: address,
        owner: address,
        kiosk: address,
    }

    public fun attributes(arg0: &Tako) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun image_hash(arg0: &Tako) : 0x1::string::String {
        arg0.image_hash
    }

    public fun buy_boxes(arg0: &mut 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::Configuration, arg1: &mut 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::FundStorage, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &0x2::transfer_policy::TransferPolicy<Tako>, arg8: &mut 0x2::tx_context::TxContext) {
        0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::assert_version(arg0);
        0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::assert_not_paused(arg0);
        let (v0, v1) = 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::check_mint_phase(arg0, arg4);
        assert!(v0 || v1, 1);
        let v2 = 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::get_box_config(arg0, arg2);
        let (_, v4) = 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::collect_sui(arg1, v2, arg3, v0);
        0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::assert_enough_box(arg0, arg2, v4);
        if (v0) {
            0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::assert_box_allocation(arg0, arg2, v4);
            0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::assert_address_allocation(arg0, 0x2::tx_context::sender(arg8), v4);
        };
        let v5 = 0;
        let v6 = 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::supply(arg0);
        assert!(v6 + v4 <= 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::max_supply(), 3);
        while (v5 < v4) {
            let v7 = mint_nft(v6 + v5, arg2, 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::image_hash(v2), arg8);
            let v8 = NewTakoMinted{
                id    : 0x2::object::uid_to_address(&v7.id),
                owner : 0x2::tx_context::sender(arg8),
                kiosk : 0x2::object::uid_to_address(0x2::kiosk::uid(arg5)),
            };
            0x2::event::emit<NewTakoMinted>(v8);
            0x2::kiosk::lock<Tako>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg6), arg7, v7);
            v5 = v5 + 1;
        };
        0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::update_after_sale(arg0, arg2, v4, v0, arg8);
    }

    public fun get_id(arg0: &Tako) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://walrus.tusky.io/{image_hash}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://tako.7k.ag/"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let (v5, v6) = 0x2::transfer_policy::new<Tako>(&v4, arg1);
        let v7 = v6;
        let v8 = v5;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Tako>(&mut v8, &v7, 700, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Tako>(&mut v8, &v7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<Tako>(&mut v8, &v7);
        let v9 = 0x2::display::new_with_fields<Tako>(&v4, v0, v2, arg1);
        0x2::display::update_version<Tako>(&mut v9);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Tako>>(v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Tako>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Tako>>(v9, 0x2::tx_context::sender(arg1));
    }

    public fun mint_for_treasury(arg0: &mut 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::Configuration, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &0x2::transfer_policy::TransferPolicy<Tako>, arg6: &0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::TreasuryCap, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::assert_version(arg0);
        0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::assert_enough_box(arg0, arg1, arg2);
        let v0 = 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::get_box_config(arg0, arg1);
        let v1 = 0;
        let v2 = 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::supply(arg0);
        assert!(v2 + arg2 <= 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::max_supply(), 3);
        while (v1 < arg2) {
            let v3 = mint_nft(v2 + v1, arg1, 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::image_hash(v0), arg7);
            let v4 = NewTakoMinted{
                id    : 0x2::object::uid_to_address(&v3.id),
                owner : 0x2::tx_context::sender(arg7),
                kiosk : 0x2::object::uid_to_address(0x2::kiosk::uid(arg3)),
            };
            0x2::event::emit<NewTakoMinted>(v4);
            0x2::kiosk::lock<Tako>(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4), arg5, v3);
            v1 = v1 + 1;
        };
        0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::update_after_sale(arg0, arg1, arg2, false, arg7);
    }

    fun mint_nft(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Tako {
        let v0 = 0x1::string::utf8(b"Tako #");
        let v1 = 0x1::u64::to_string(arg0);
        let v2 = 0x1::string::length(&v1);
        let v3 = &v2;
        let v4 = if (*v3 == 1) {
            b"000"
        } else if (*v3 == 2) {
            b"00"
        } else if (*v3 == 3) {
            b"0"
        } else {
            b""
        };
        0x1::string::append_utf8(&mut v0, v4);
        0x1::string::append(&mut v0, v1);
        let v5 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"Rarity"), arg1);
        Tako{
            id          : 0x2::object::new(arg3),
            name        : v0,
            image_hash  : arg2,
            description : 0x1::string::utf8(b"The Legendary Octo-Warrior of the 7K Universe!"),
            attributes  : v5,
        }
    }

    fun reveal_attributes(arg0: &mut 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::attributes::AttributesRegistry, arg1: &mut 0x2::random::RandomGenerator, arg2: &mut Tako, arg3: &0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::Configuration, arg4: 0x1::string::String) {
        assert!(0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::attributes::check_enough_attributes(arg0), 0);
        let v0 = 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::generate_tier(arg3, arg4, arg1);
        let v1 = 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::attributes::random_attributes(arg0, arg1, v0);
        arg2.image_hash = 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::attributes::image_hash(&v1);
        arg2.attributes = 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::attributes::attributes(&v1);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg2.attributes, 0x1::string::utf8(b"Tier"), v0);
    }

    entry fun reveal_tako(arg0: &0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::Configuration, arg1: &mut 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::attributes::AttributesRegistry, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: &mut 0x2::tx_context::TxContext) {
        0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::assert_version(arg0);
        0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config::assert_can_reveal(arg0);
        let v0 = 0x2::kiosk::borrow_mut<Tako>(arg4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg5), arg2);
        let v1 = 0x1::string::utf8(b"Rarity");
        let v2 = *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v0.attributes, &v1);
        let v3 = 0x2::random::new_generator(arg3, arg6);
        let v4 = &mut v3;
        reveal_attributes(arg1, v4, v0, arg0, v2);
    }

    // decompiled from Move bytecode v6
}

