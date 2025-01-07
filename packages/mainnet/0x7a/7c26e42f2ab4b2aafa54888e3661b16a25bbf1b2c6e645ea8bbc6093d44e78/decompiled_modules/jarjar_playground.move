module 0x7a7c26e42f2ab4b2aafa54888e3661b16a25bbf1b2c6e645ea8bbc6093d44e78::jarjar_playground {
    struct JARJAR_PLAYGROUND has drop {
        dummy_field: bool,
    }

    struct JarJarPlaygroundNFT has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        number: 0x1::string::String,
    }

    struct CallbackEvent has copy, drop {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        number: 0x1::string::String,
    }

    public fun callback(arg0: 0x1::string::String, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle::OwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle::get_owner_cap_address(arg4), 2);
        let v0 = JarJarPlaygroundNFT{
            id          : 0x2::object::new(arg5),
            image_url   : arg0,
            description : arg2,
            number      : arg3,
        };
        0x2::transfer::public_transfer<JarJarPlaygroundNFT>(v0, arg1);
        let v1 = CallbackEvent{
            name        : 0x1::string::utf8(b"jarjar_playground"),
            description : arg2,
            image_url   : arg0,
            number      : arg3,
        };
        0x2::event::emit<CallbackEvent>(v1);
    }

    public fun generate(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::price_model::PriceModel, arg5: &mut 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle::OwnerCap, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 3);
        assert!(arg6 <= 4, 3);
        let v0 = 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::price_model::get_price(arg4, &arg2) * (arg6 as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 1);
        0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle::generate(arg0, arg1, arg2, 0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg3), v0, arg7), arg4, arg5, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle::get_owner_cap_address(arg5));
    }

    fun init(arg0: JARJAR_PLAYGROUND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"number"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"jarjar_playground"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://playground.jarjar.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/JARJARxyz"));
        let v4 = 0x2::package::claim<JARJAR_PLAYGROUND>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<JarJarPlaygroundNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<JarJarPlaygroundNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<JarJarPlaygroundNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

