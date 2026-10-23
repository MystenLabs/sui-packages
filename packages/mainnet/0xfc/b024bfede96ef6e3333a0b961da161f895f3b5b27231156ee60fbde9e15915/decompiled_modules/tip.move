module 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tip {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_cap: u64,
        free_below: u64,
        fee_recipient: address,
    }

    struct TipEvent has copy, drop {
        tipper: address,
        creator: address,
        referrer: address,
        amount: u64,
        creator_amount: u64,
        referrer_amount: u64,
        fee_amount: u64,
    }

    struct MintFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PagePriceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TipNoteEvent has copy, drop {
        tipper: address,
        creator: address,
        amount: u64,
        note: 0x1::string::String,
        anonymous: bool,
    }

    struct CreatorRefKey has copy, drop, store {
        creator: address,
    }

    struct CreditTypeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CreditUsedKey has copy, drop, store {
        who: address,
    }

    struct HolderPriceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HolderLinkPaid has copy, drop {
        payer: address,
        amount: u64,
        commit: vector<u8>,
    }

    struct QuoteKeyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HolderLinkPaidV2 has copy, drop {
        payer: address,
        coin: 0x1::ascii::String,
        amount: u64,
        commit: vector<u8>,
    }

    struct AirdropFeeUsdKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AirdropFeePaid has copy, drop {
        payer: address,
        usd_cents: u64,
        amount: u64,
        recipients: u64,
    }

    public fun tip(arg0: &Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = eff_ref_bps(arg0, arg2, arg4);
        let v2 = arg3 != @0x0 && v1 > 0;
        assert!(!v2 || arg3 != v0 && arg3 != arg2, 4);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let (v4, v5, v6) = quote(arg0, v3, v2, v1);
        let (v7, v8) = if (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(v0) || 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(arg2)) {
            (v4 + v6, 0)
        } else {
            (v4, v6)
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v8, arg5), arg0.fee_recipient);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v5, arg5), arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg2);
        let v9 = if (v2) {
            arg3
        } else {
            @0x0
        };
        let v10 = TipEvent{
            tipper          : v0,
            creator         : arg2,
            referrer        : v9,
            amount          : v3,
            creator_amount  : v7,
            referrer_amount : v5,
            fee_amount      : v8,
        };
        0x2::event::emit<TipEvent>(v10);
    }

    public fun airdrop_fee_mist(arg0: &Config, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v0);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v1) == x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744", 9104);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg1);
        let v3 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v2);
        assert!(v4 <= v3 + 10, 9102);
        assert!(v4 + 90 >= v3, 9102);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v2);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v5), 9105);
        let v6 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v5);
        assert!(v6 > 0, 9105);
        assert!((0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v2) as u128) * 10000 <= (v6 as u128) * 200, 9103);
        let v7 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v2);
        let (v8, v9) = if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v7)) {
            (true, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v7))
        } else {
            (false, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v7))
        };
        usd_cents_to_mist(airdrop_fee_usd_cents(arg0), v6, v8, v9)
    }

    public fun airdrop_fee_usd_cents(arg0: &Config) : u64 {
        let v0 = AirdropFeeUsdKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AirdropFeeUsdKey>(&arg0.id, v0)) {
            let v2 = AirdropFeeUsdKey{dummy_field: false};
            *0x2::dynamic_field::borrow<AirdropFeeUsdKey, u64>(&arg0.id, v2)
        } else {
            200
        }
    }

    public fun credit_type(arg0: &Config) : 0x1::ascii::String {
        let v0 = CreditTypeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CreditTypeKey>(&arg0.id, v0)) {
            let v2 = CreditTypeKey{dummy_field: false};
            *0x2::dynamic_field::borrow<CreditTypeKey, 0x1::ascii::String>(&arg0.id, v2)
        } else {
            0x1::ascii::string(b"")
        }
    }

    public fun credit_used(arg0: &Config, arg1: address) : bool {
        let v0 = CreditUsedKey{who: arg1};
        0x2::dynamic_field::exists<CreditUsedKey>(&arg0.id, v0)
    }

    public fun eff_ref_bps(arg0: &Config, arg1: address, arg2: u64) : u64 {
        let v0 = CreatorRefKey{creator: arg1};
        if (0x2::dynamic_field::exists<CreatorRefKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<CreatorRefKey, u64>(&arg0.id, v0)
        } else {
            arg2
        }
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    public fun has_creator_ref_bps(arg0: &Config, arg1: address) : bool {
        let v0 = CreatorRefKey{creator: arg1};
        0x2::dynamic_field::exists<CreatorRefKey>(&arg0.id, v0)
    }

    public fun holder_price(arg0: &Config) : u64 {
        let v0 = HolderPriceKey{dummy_field: false};
        if (0x2::dynamic_field::exists<HolderPriceKey>(&arg0.id, v0)) {
            let v2 = HolderPriceKey{dummy_field: false};
            *0x2::dynamic_field::borrow<HolderPriceKey, u64>(&arg0.id, v2)
        } else {
            2000000000
        }
    }

    public fun holder_quote_message<T0>(arg0: address, arg1: vector<u8>, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = b"tapdrop-holder-fee";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id            : 0x2::object::new(arg0),
            fee_bps       : 100,
            fee_cap       : 1000000000,
            free_below    : 1000000000,
            fee_recipient : v0,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun is_clean_note(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        if (0x1::vector::length<u8>(v0) > 560) {
            return false
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            if (v2 < 32 || v2 == 127) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun mint_fee_bps(arg0: &Config) : u64 {
        let v0 = MintFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MintFeeKey>(&arg0.id, v0)) {
            let v2 = MintFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow<MintFeeKey, u64>(&arg0.id, v2)
        } else {
            250
        }
    }

    public fun page_price(arg0: &Config) : u64 {
        let v0 = PagePriceKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PagePriceKey>(&arg0.id, v0)) {
            let v2 = PagePriceKey{dummy_field: false};
            *0x2::dynamic_field::borrow<PagePriceKey, u64>(&arg0.id, v2)
        } else {
            250000000
        }
    }

    public fun pay_airdrop_fee(arg0: &Config, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
            let v1 = AirdropFeePaid{
                payer      : v0,
                usd_cents  : 0,
                amount     : 0,
                recipients : arg4,
            };
            0x2::event::emit<AirdropFeePaid>(v1);
            return
        };
        let v2 = airdrop_fee_mist(arg0, arg1, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v2, 9101);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2, arg5), arg0.fee_recipient);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v3 = AirdropFeePaid{
            payer      : v0,
            usd_cents  : airdrop_fee_usd_cents(arg0),
            amount     : v2,
            recipients : arg4,
        };
        0x2::event::emit<AirdropFeePaid>(v3);
    }

    public fun pay_holder_link(arg0: &Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        abort 9003
    }

    public fun pay_holder_link_quoted<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 9002);
        if (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::exempt::is_exempt(0x2::tx_context::sender(arg7))) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg7));
            let v0 = HolderLinkPaidV2{
                payer  : 0x2::tx_context::sender(arg7),
                coin   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                amount : 0,
                commit : arg2,
            };
            0x2::event::emit<HolderLinkPaidV2>(v0);
            return
        };
        assert!(0x2::clock::timestamp_ms(arg6) < arg4, 9005);
        assert!(arg3 > 0 && 0x2::coin::value<T0>(&arg1) == arg3, 9001);
        let v1 = QuoteKeyKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<QuoteKeyKey>(&arg0.id, v1), 9004);
        let v2 = QuoteKeyKey{dummy_field: false};
        let v3 = holder_quote_message<T0>(0x2::tx_context::sender(arg7), arg2, arg3, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg5, 0x2::dynamic_field::borrow<QuoteKeyKey, vector<u8>>(&arg0.id, v2), &v3), 9004);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.fee_recipient);
        let v4 = HolderLinkPaidV2{
            payer  : 0x2::tx_context::sender(arg7),
            coin   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount : arg3,
            commit : arg2,
        };
        0x2::event::emit<HolderLinkPaidV2>(v4);
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun quote(arg0: &Config, arg1: u64, arg2: bool, arg3: u64) : (u64, u64, u64) {
        assert!(arg1 > 0, 1);
        assert!(arg3 <= 1000, 3);
        let v0 = if (arg1 < arg0.free_below) {
            0
        } else {
            (((arg1 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64)
        };
        let v1 = v0;
        if (v0 > arg0.fee_cap) {
            v1 = arg0.fee_cap;
        };
        let v2 = if (arg2) {
            (((arg1 as u128) * (arg3 as u128) / (10000 as u128)) as u64)
        } else {
            0
        };
        (arg1 - v1 - v2, v2, v1)
    }

    public fun set_airdrop_fee_usd(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 2000, 9106);
        let v0 = AirdropFeeUsdKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AirdropFeeUsdKey>(&arg1.id, v0)) {
            let v1 = AirdropFeeUsdKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<AirdropFeeUsdKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = AirdropFeeUsdKey{dummy_field: false};
            0x2::dynamic_field::add<AirdropFeeUsdKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_creator_ref_bps(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 1000, 3);
        let v0 = CreatorRefKey{creator: 0x2::tx_context::sender(arg2)};
        if (0x2::dynamic_field::exists<CreatorRefKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<CreatorRefKey, u64>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<CreatorRefKey, u64>(&mut arg0.id, v0, arg1);
        };
    }

    public fun set_credit_type(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::ascii::String) {
        let v0 = CreditTypeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CreditTypeKey>(&arg1.id, v0)) {
            let v1 = CreditTypeKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<CreditTypeKey, 0x1::ascii::String>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = CreditTypeKey{dummy_field: false};
            0x2::dynamic_field::add<CreditTypeKey, 0x1::ascii::String>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 <= 500, 2);
        arg1.fee_bps = arg2;
        arg1.fee_cap = arg3;
        arg1.free_below = arg4;
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public fun set_holder_price(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 100000000000, 2);
        let v0 = HolderPriceKey{dummy_field: false};
        if (0x2::dynamic_field::exists<HolderPriceKey>(&arg1.id, v0)) {
            let v1 = HolderPriceKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<HolderPriceKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = HolderPriceKey{dummy_field: false};
            0x2::dynamic_field::add<HolderPriceKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_mint_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 500, 2);
        let v0 = MintFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MintFeeKey>(&arg1.id, v0)) {
            let v1 = MintFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<MintFeeKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = MintFeeKey{dummy_field: false};
            0x2::dynamic_field::add<MintFeeKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_page_price(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 100000000000, 2);
        let v0 = PagePriceKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PagePriceKey>(&arg1.id, v0)) {
            let v1 = PagePriceKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<PagePriceKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = PagePriceKey{dummy_field: false};
            0x2::dynamic_field::add<PagePriceKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_quote_pubkey(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        let v0 = QuoteKeyKey{dummy_field: false};
        if (0x2::dynamic_field::exists<QuoteKeyKey>(&arg1.id, v0)) {
            let v1 = QuoteKeyKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<QuoteKeyKey, vector<u8>>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = QuoteKeyKey{dummy_field: false};
            0x2::dynamic_field::add<QuoteKeyKey, vector<u8>>(&mut arg1.id, v2, arg2);
        };
    }

    public fun tip_with_note(arg0: &Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: address, arg4: u64, arg5: 0x1::string::String, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg5)) <= 560, 5);
        assert!(is_clean_note(&arg5), 6);
        tip(arg0, arg1, arg2, arg3, arg4, arg7);
        let v0 = TipNoteEvent{
            tipper    : 0x2::tx_context::sender(arg7),
            creator   : arg2,
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            note      : arg5,
            anonymous : arg6,
        };
        0x2::event::emit<TipNoteEvent>(v0);
    }

    public fun usd_cents_to_mist(arg0: u64, arg1: u64, arg2: bool, arg3: u64) : u64 {
        assert!(arg1 > 0 && arg3 <= 18, 9105);
        let (v0, v1) = if (arg2) {
            ((arg0 as u128) * pow10(7 + arg3), (arg1 as u128))
        } else if (arg3 <= 7) {
            ((arg0 as u128) * pow10(7 - arg3), (arg1 as u128))
        } else {
            ((arg0 as u128), (arg1 as u128) * pow10(arg3 - 7))
        };
        let v2 = (v0 + v1 - 1) / v1;
        assert!(v2 <= 18446744073709551615, 9105);
        (v2 as u64)
    }

    public(friend) fun use_credit<T0: drop>(arg0: &mut Config, arg1: address) {
        let v0 = credit_type(arg0);
        assert!(0x1::ascii::length(&v0) > 0 && 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == v0, 20);
        assert!(!credit_used(arg0, arg1), 21);
        let v1 = CreditUsedKey{who: arg1};
        0x2::dynamic_field::add<CreditUsedKey, bool>(&mut arg0.id, v1, true);
    }

    // decompiled from Move bytecode v7
}

