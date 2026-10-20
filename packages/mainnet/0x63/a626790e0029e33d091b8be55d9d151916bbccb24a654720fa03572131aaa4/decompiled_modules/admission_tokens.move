module 0x63a626790e0029e33d091b8be55d9d151916bbccb24a654720fa03572131aaa4::admission_tokens {
    struct Fixed has key {
        id: 0x2::object::UID,
    }

    struct BurnOnly has key {
        id: 0x2::object::UID,
    }

    struct Regulated has key {
        id: 0x2::object::UID,
    }

    struct Pausable has key {
        id: 0x2::object::UID,
    }

    public fun create_sale<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: &0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::creation_policy::CreationPolicy, arg3: &0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::fee_policy::FeePolicy, arg4: &mut 0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::venue_config::VenueConfig, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::bluefin::new<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, 10, 1000);
        0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::set_supply<T0, 0x2::sui::SUI>(&mut v0, 1000000000, arg5);
        0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::set_token_allocations<T0, 0x2::sui::SUI>(&mut v0, 0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::bps::new(5000), 0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::bps::new(5000), 0x1::vector::empty<0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::RecipientShare>());
        0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::set_raise<T0, 0x2::sui::SUI>(&mut v0, 1000000000, 0x1::vector::empty<0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::RecipientShare>());
        0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::set_windows<T0, 0x2::sui::SUI>(&mut v0, 1000, 604800000);
        0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::set_eligibility<T0, 0x2::sui::SUI>(&mut v0, 0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::open_eligibility(1000000000, 1, 1000000000));
        let v1 = 0x1::vector::empty<0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::RecipientShare>();
        0x1::vector::push_back<0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::RecipientShare>(&mut v1, 0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::recipient_share(0x2::tx_context::sender(arg7), 0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::bps::new(10000)));
        0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::set_fee_split<T0, 0x2::sui::SUI>(&mut v0, 0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::fee_split(v1, 0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::bps::new(0)));
        let (v2, v3) = 0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::finalize<T0, 0x2::sui::SUI>(v0, arg1, arg7);
        0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::share<T0, 0x2::sui::SUI>(v2, 0, arg6);
        0x2::transfer::public_transfer<0x2c0ce340b5652d3ce8b813f47f728f335835a1aacd9ecac4a6e23c260404844d::blast_presale::PresaleCap>(v3, 0x2::tx_context::sender(arg7));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 128) {
            0x1::vector::push_back<u8>(&mut v0, 65);
            v1 = v1 + 1;
        };
        let v2 = b"";
        let v3 = 0;
        while (v3 < 16384) {
            0x1::vector::push_back<u8>(&mut v2, 66);
            v3 = v3 + 1;
        };
        let (v4, v5) = 0x2::coin_registry::new_currency<Fixed>(arg0, 9, 0x1::string::utf8(b"ADMISSIONTEST"), 0x1::string::utf8(v0), 0x1::string::utf8(v2), 0x1::string::utf8(b""), arg1);
        let v6 = v4;
        let v7 = 0x1::option::none<bool>();
        if (0x1::option::is_some<bool>(&v7)) {
            0x2::transfer::public_transfer<0x2::coin::DenyCapV2<Fixed>>(0x2::coin_registry::make_regulated<Fixed>(&mut v6, 0x1::option::destroy_some<bool>(v7), arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x1::option::destroy_none<bool>(v7);
        };
        0x2::coin_registry::finalize_and_delete_metadata_cap<Fixed>(v6, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Fixed>>(v5, 0x2::tx_context::sender(arg1));
        let v8 = b"";
        let v9 = 0;
        while (v9 < 128) {
            0x1::vector::push_back<u8>(&mut v8, 65);
            v9 = v9 + 1;
        };
        let v10 = b"";
        let v11 = 0;
        while (v11 < 16384) {
            0x1::vector::push_back<u8>(&mut v10, 66);
            v11 = v11 + 1;
        };
        let (v12, v13) = 0x2::coin_registry::new_currency<BurnOnly>(arg0, 9, 0x1::string::utf8(b"ADMISSIONTEST"), 0x1::string::utf8(v8), 0x1::string::utf8(v10), 0x1::string::utf8(b""), arg1);
        let v14 = v12;
        let v15 = 0x1::option::none<bool>();
        if (0x1::option::is_some<bool>(&v15)) {
            0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BurnOnly>>(0x2::coin_registry::make_regulated<BurnOnly>(&mut v14, 0x1::option::destroy_some<bool>(v15), arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x1::option::destroy_none<bool>(v15);
        };
        0x2::coin_registry::finalize_and_delete_metadata_cap<BurnOnly>(v14, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BurnOnly>>(v13, 0x2::tx_context::sender(arg1));
        let v16 = b"";
        let v17 = 0;
        while (v17 < 128) {
            0x1::vector::push_back<u8>(&mut v16, 65);
            v17 = v17 + 1;
        };
        let v18 = b"";
        let v19 = 0;
        while (v19 < 16384) {
            0x1::vector::push_back<u8>(&mut v18, 66);
            v19 = v19 + 1;
        };
        let (v20, v21) = 0x2::coin_registry::new_currency<Regulated>(arg0, 9, 0x1::string::utf8(b"ADMISSIONTEST"), 0x1::string::utf8(v16), 0x1::string::utf8(v18), 0x1::string::utf8(b""), arg1);
        let v22 = v20;
        let v23 = 0x1::option::some<bool>(false);
        if (0x1::option::is_some<bool>(&v23)) {
            0x2::transfer::public_transfer<0x2::coin::DenyCapV2<Regulated>>(0x2::coin_registry::make_regulated<Regulated>(&mut v22, 0x1::option::destroy_some<bool>(v23), arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x1::option::destroy_none<bool>(v23);
        };
        0x2::coin_registry::finalize_and_delete_metadata_cap<Regulated>(v22, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Regulated>>(v21, 0x2::tx_context::sender(arg1));
        let v24 = b"";
        let v25 = 0;
        while (v25 < 128) {
            0x1::vector::push_back<u8>(&mut v24, 65);
            v25 = v25 + 1;
        };
        let v26 = b"";
        let v27 = 0;
        while (v27 < 16384) {
            0x1::vector::push_back<u8>(&mut v26, 66);
            v27 = v27 + 1;
        };
        let (v28, v29) = 0x2::coin_registry::new_currency<Pausable>(arg0, 9, 0x1::string::utf8(b"ADMISSIONTEST"), 0x1::string::utf8(v24), 0x1::string::utf8(v26), 0x1::string::utf8(b""), arg1);
        let v30 = v28;
        let v31 = 0x1::option::some<bool>(true);
        if (0x1::option::is_some<bool>(&v31)) {
            0x2::transfer::public_transfer<0x2::coin::DenyCapV2<Pausable>>(0x2::coin_registry::make_regulated<Pausable>(&mut v30, 0x1::option::destroy_some<bool>(v31), arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x1::option::destroy_none<bool>(v31);
        };
        0x2::coin_registry::finalize_and_delete_metadata_cap<Pausable>(v30, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Pausable>>(v29, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

