module 0x2ed8405d70de84fe07cc7bd7a18424644a890815efcbbb0c3cd272b462873a1f::admission_tokens {
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

    public fun create_sale<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale_package::PackageVersion, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::creation_policy::CreationPolicy, arg4: &0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::fee_policy::FeePolicy, arg5: &mut 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::venue_config::VenueConfig, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bluefin::new<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, 10, 1000);
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::set_supply<T0, 0x2::sui::SUI>(&mut v0, arg1, 1000000000, arg6);
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::set_token_allocations<T0, 0x2::sui::SUI>(&mut v0, arg1, 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::new(5000), 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::new(5000), 0x1::vector::empty<0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::RecipientShare>());
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::set_raise<T0, 0x2::sui::SUI>(&mut v0, arg1, 1000000000, 0x1::vector::empty<0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::RecipientShare>());
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::set_windows<T0, 0x2::sui::SUI>(&mut v0, arg1, 1000, 604800000);
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::set_eligibility<T0, 0x2::sui::SUI>(&mut v0, arg1, 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::open_eligibility(1000000000, 1, 1000000000));
        let v1 = 0x1::vector::empty<0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::RecipientShare>();
        0x1::vector::push_back<0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::RecipientShare>(&mut v1, 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::recipient_share(0x2::tx_context::sender(arg8), 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::new(10000)));
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::set_fee_split<T0, 0x2::sui::SUI>(&mut v0, arg1, 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::fee_split(v1, 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::bps::new(0)));
        let (v2, v3) = 0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::finalize<T0, 0x2::sui::SUI>(v0, arg1, arg2, arg8);
        0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::share<T0, 0x2::sui::SUI>(v2, arg1, 0, arg7);
        0x2::transfer::public_transfer<0xafc415fa1187577c60205ccff10151fca540b088a3b84f798b90ae0642fa83f8::blast_presale::PresaleCap>(v3, 0x2::tx_context::sender(arg8));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<Fixed>(arg0, 9, 0x1::string::utf8(b"ADMISSIONTEST"), 0x1::string::utf8(b"Worthless activation test"), 0x1::string::utf8(b"Test only. No economic value."), 0x1::string::utf8(b""), arg1);
        let v2 = v0;
        let v3 = 0x1::option::none<bool>();
        if (0x1::option::is_some<bool>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::DenyCapV2<Fixed>>(0x2::coin_registry::make_regulated<Fixed>(&mut v2, 0x1::option::destroy_some<bool>(v3), arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x1::option::destroy_none<bool>(v3);
        };
        0x2::coin_registry::finalize_and_delete_metadata_cap<Fixed>(v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Fixed>>(v1, 0x2::tx_context::sender(arg1));
        let (v4, v5) = 0x2::coin_registry::new_currency<BurnOnly>(arg0, 9, 0x1::string::utf8(b"ADMISSIONTEST"), 0x1::string::utf8(b"Worthless activation test"), 0x1::string::utf8(b"Test only. No economic value."), 0x1::string::utf8(b""), arg1);
        let v6 = v4;
        let v7 = 0x1::option::none<bool>();
        if (0x1::option::is_some<bool>(&v7)) {
            0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BurnOnly>>(0x2::coin_registry::make_regulated<BurnOnly>(&mut v6, 0x1::option::destroy_some<bool>(v7), arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x1::option::destroy_none<bool>(v7);
        };
        0x2::coin_registry::finalize_and_delete_metadata_cap<BurnOnly>(v6, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BurnOnly>>(v5, 0x2::tx_context::sender(arg1));
        let (v8, v9) = 0x2::coin_registry::new_currency<Regulated>(arg0, 9, 0x1::string::utf8(b"ADMISSIONTEST"), 0x1::string::utf8(b"Worthless activation test"), 0x1::string::utf8(b"Test only. No economic value."), 0x1::string::utf8(b""), arg1);
        let v10 = v8;
        let v11 = 0x1::option::some<bool>(false);
        if (0x1::option::is_some<bool>(&v11)) {
            0x2::transfer::public_transfer<0x2::coin::DenyCapV2<Regulated>>(0x2::coin_registry::make_regulated<Regulated>(&mut v10, 0x1::option::destroy_some<bool>(v11), arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x1::option::destroy_none<bool>(v11);
        };
        0x2::coin_registry::finalize_and_delete_metadata_cap<Regulated>(v10, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Regulated>>(v9, 0x2::tx_context::sender(arg1));
        let (v12, v13) = 0x2::coin_registry::new_currency<Pausable>(arg0, 9, 0x1::string::utf8(b"ADMISSIONTEST"), 0x1::string::utf8(b"Worthless activation test"), 0x1::string::utf8(b"Test only. No economic value."), 0x1::string::utf8(b""), arg1);
        let v14 = v12;
        let v15 = 0x1::option::some<bool>(true);
        if (0x1::option::is_some<bool>(&v15)) {
            0x2::transfer::public_transfer<0x2::coin::DenyCapV2<Pausable>>(0x2::coin_registry::make_regulated<Pausable>(&mut v14, 0x1::option::destroy_some<bool>(v15), arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x1::option::destroy_none<bool>(v15);
        };
        0x2::coin_registry::finalize_and_delete_metadata_cap<Pausable>(v14, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Pausable>>(v13, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

