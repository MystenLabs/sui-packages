module 0x294b4ff76830aaace850ba390fad5f2bb7692a36cb5b4b4f078590a0bb34e24f::certificate {
    struct CERTIFICATE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        issuer: 0x2::object::ID,
        daily_limit: u64,
        day: u64,
        minted_today: u64,
    }

    struct Issuer has key {
        id: 0x2::object::UID,
        last_serial: u64,
        coin_type: 0x1::option::Option<0x1::type_name::TypeName>,
        payee: address,
        price: u64,
        paused: bool,
        mint_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        allowed_templates: 0x2::vec_set::VecSet<0x1::string::String>,
        used_payments: 0x2::table::Table<vector<u8>, u64>,
    }

    struct SpiceCertificate has key {
        id: 0x2::object::UID,
        serial: u64,
        holder: address,
        license_id: 0x2::object::ID,
        issue_ts_ms: u64,
        principal: u64,
        rate_bps: u64,
        status: u8,
        payout_asset: u8,
        requested_ts_ms: u64,
        payment_ref: vector<u8>,
    }

    struct IssuerConfigured has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        payee: address,
        price: u64,
    }

    struct PayeeChanged has copy, drop {
        old: address,
        new: address,
    }

    struct PausedSet has copy, drop {
        paused: bool,
    }

    struct MintCapCreated has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
        daily_limit: u64,
    }

    struct MintCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct TemplateAllowed has copy, drop {
        template_id: 0x1::string::String,
        allowed: bool,
    }

    struct CertificateMinted has copy, drop {
        cert_id: 0x2::object::ID,
        serial: u64,
        holder: address,
        license_id: 0x2::object::ID,
        principal: u64,
        rate_bps: u64,
        path: u8,
        payment_ref: vector<u8>,
    }

    struct RedemptionRequested has copy, drop {
        cert_id: 0x2::object::ID,
        serial: u64,
        holder: address,
        payout_asset: u8,
        requested_ts_ms: u64,
    }

    struct RedemptionRejected has copy, drop {
        cert_id: 0x2::object::ID,
        serial: u64,
        holder: address,
        reason: 0x1::string::String,
    }

    struct CertificateBurned has copy, drop {
        cert_id: 0x2::object::ID,
        serial: u64,
        holder: address,
        payout_asset: u8,
        payout_amount: u64,
        payout_tx: 0x1::string::String,
        burned_ts_ms: u64,
    }

    public fun burn_redeemed(arg0: &AdminCap, arg1: &mut Issuer, arg2: 0x2::transfer::Receiving<SpiceCertificate>, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        assert!(!0x1::string::is_empty(&arg4), 10);
        let v0 = 0x2::transfer::receive<SpiceCertificate>(&mut arg1.id, arg2);
        assert!(v0.status == 1, 8);
        let SpiceCertificate {
            id              : v1,
            serial          : v2,
            holder          : v3,
            license_id      : _,
            issue_ts_ms     : _,
            principal       : _,
            rate_bps        : _,
            status          : _,
            payout_asset    : v9,
            requested_ts_ms : _,
            payment_ref     : _,
        } = v0;
        let v12 = v1;
        let v13 = CertificateBurned{
            cert_id       : 0x2::object::uid_to_inner(&v12),
            serial        : v2,
            holder        : v3,
            payout_asset  : v9,
            payout_amount : arg3,
            payout_tx     : arg4,
            burned_ts_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CertificateBurned>(v13);
        0x2::object::delete(v12);
    }

    fun check_coin<T0>(arg0: &Issuer) {
        assert!(!arg0.paused, 4);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.coin_type), 1);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.coin_type) == 0x1::type_name::with_defining_ids<T0>(), 2);
    }

    public fun configure<T0>(arg0: &AdminCap, arg1: &mut Issuer, arg2: u64) {
        assert!(arg2 > 0, 3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        arg1.coin_type = 0x1::option::some<0x1::type_name::TypeName>(v0);
        arg1.price = arg2;
        let v1 = IssuerConfigured{
            coin_type : v0,
            payee     : arg1.payee,
            price     : arg2,
        };
        0x2::event::emit<IssuerConfigured>(v1);
    }

    public fun create_mint_cap(arg0: &AdminCap, arg1: &mut Issuer, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{
            id           : 0x2::object::new(arg4),
            issuer       : 0x2::object::id<Issuer>(arg1),
            daily_limit  : arg3,
            day          : 0,
            minted_today : 0,
        };
        let v1 = 0x2::object::id<MintCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.mint_caps, v1);
        let v2 = MintCapCreated{
            cap_id      : v1,
            recipient   : arg2,
            daily_limit : arg3,
        };
        0x2::event::emit<MintCapCreated>(v2);
        0x2::transfer::transfer<MintCap>(v0, arg2);
    }

    public fun holder(arg0: &SpiceCertificate) : address {
        arg0.holder
    }

    fun init(arg0: CERTIFICATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CERTIFICATE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Spice Certificate No. {serial}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Spice Certificate No. {serial} from The Spice Melange. Holders only, non-transferable, perpetual. 100 USDC principal; 8% APR target credited in BTC sats, rounded down daily (a target, not a promise). Withdrawal can be requested any time; every payout approved by hand; 6-hour payout target, not a promise. Not a bank deposit, not insured; you can lose money."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://thespicemelange.org/og/spice-melange-og.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://thespicemelange.org/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://thespicemelange.org/terms/"));
        let v5 = 0x2::display::new_with_fields<SpiceCertificate>(&v0, v1, v3, arg1);
        0x2::display::update_version<SpiceCertificate>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SpiceCertificate>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = Issuer{
            id                : 0x2::object::new(arg1),
            last_serial       : 0,
            coin_type         : 0x1::option::none<0x1::type_name::TypeName>(),
            payee             : @0x88e8516771e71da54a7449a0a46e6a0c4af71ef71ac4d379847319c7e18a780f,
            price             : 0,
            paused            : true,
            mint_caps         : 0x2::vec_set::empty<0x2::object::ID>(),
            allowed_templates : 0x2::vec_set::singleton<0x1::string::String>(0x1::string::utf8(b"dune-saga-collection")),
            used_payments     : 0x2::table::new<vector<u8>, u64>(arg1),
        };
        0x2::transfer::share_object<Issuer>(v7);
    }

    public fun is_test_order(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"SM-TEST";
        let v2 = 0x1::vector::length<u8>(&v1);
        if (0x1::vector::length<u8>(v0) < v2) {
            return false
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(v0, v3);
            let v5 = v4;
            if (v4 >= 97 && v4 <= 122) {
                v5 = v4 - 32;
            };
            if (v5 != *0x1::vector::borrow<u8>(&v1, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    public fun issue_ts_ms(arg0: &SpiceCertificate) : u64 {
        arg0.issue_ts_ms
    }

    public fun license_id(arg0: &SpiceCertificate) : 0x2::object::ID {
        arg0.license_id
    }

    public fun license_qualifies(arg0: &Issuer, arg1: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskLicense) : bool {
        let v0 = 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::template_id(arg1);
        if (0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_templates, &v0)) {
            let v2 = 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::order_id(arg1);
            !is_test_order(&v2)
        } else {
            false
        }
    }

    public fun mint_cap_active(arg0: &Issuer, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.mint_caps, &arg1)
    }

    public fun mint_for_payment(arg0: &mut MintCap, arg1: &mut Issuer, arg2: address, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.issuer == 0x2::object::id<Issuer>(arg1), 13);
        let v0 = 0x2::object::id<MintCap>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.mint_caps, &v0), 12);
        if (arg0.daily_limit > 0) {
            let v1 = 0x2::clock::timestamp_ms(arg5) / 86400000;
            if (arg0.day != v1) {
                arg0.day = v1;
                arg0.minted_today = 0;
            };
            assert!(arg0.minted_today < arg0.daily_limit, 14);
            arg0.minted_today = arg0.minted_today + 1;
        };
        assert!(!arg1.paused, 4);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg1.coin_type), 1);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 11);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 18);
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg1.used_payments, arg4), 5);
        0x2::table::add<vector<u8>, u64>(&mut arg1.used_payments, arg4, arg1.last_serial + 1);
        mint_to(arg1, arg2, arg3, 1, arg4, arg5, arg6);
    }

    fun mint_to(arg0: &mut Issuer, arg1: address, arg2: 0x2::object::ID, arg3: u8, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        arg0.last_serial = arg0.last_serial + 1;
        let v0 = SpiceCertificate{
            id              : 0x2::object::new(arg6),
            serial          : arg0.last_serial,
            holder          : arg1,
            license_id      : arg2,
            issue_ts_ms     : 0x2::clock::timestamp_ms(arg5),
            principal       : arg0.price,
            rate_bps        : 800,
            status          : 0,
            payout_asset    : 0,
            requested_ts_ms : 0,
            payment_ref     : arg4,
        };
        let v1 = CertificateMinted{
            cert_id     : 0x2::object::id<SpiceCertificate>(&v0),
            serial      : v0.serial,
            holder      : arg1,
            license_id  : arg2,
            principal   : v0.principal,
            rate_bps    : 800,
            path        : arg3,
            payment_ref : arg4,
        };
        0x2::event::emit<CertificateMinted>(v1);
        0x2::transfer::transfer<SpiceCertificate>(v0, arg1);
    }

    public fun paused(arg0: &Issuer) : bool {
        arg0.paused
    }

    public fun payee(arg0: &Issuer) : address {
        arg0.payee
    }

    public fun payment_used(arg0: &Issuer, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u64>(&arg0.used_payments, arg1)
    }

    public fun payout_asset(arg0: &SpiceCertificate) : u8 {
        arg0.payout_asset
    }

    public fun pinned_payee() : address {
        @0x88e8516771e71da54a7449a0a46e6a0c4af71ef71ac4d379847319c7e18a780f
    }

    public fun price(arg0: &Issuer) : u64 {
        arg0.price
    }

    public fun principal(arg0: &SpiceCertificate) : u64 {
        arg0.principal
    }

    public fun purchase<T0>(arg0: &mut Issuer, arg1: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskLicense, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_coin<T0>(arg0);
        let v0 = 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::template_id(arg1);
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_templates, &v0), 16);
        let v1 = 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::order_id(arg1);
        assert!(!is_test_order(&v1), 17);
        assert!(0x2::coin::value<T0>(&arg2) == arg0.price, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.payee);
        let v2 = *0x2::tx_context::digest(arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        mint_to(arg0, v3, 0x2::object::id<0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskLicense>(arg1), 0, v2, arg3, arg4);
    }

    public fun rate_bps(arg0: &SpiceCertificate) : u64 {
        arg0.rate_bps
    }

    public fun reject_redemption(arg0: &AdminCap, arg1: &mut Issuer, arg2: 0x2::transfer::Receiving<SpiceCertificate>, arg3: 0x1::string::String) {
        let v0 = 0x2::transfer::receive<SpiceCertificate>(&mut arg1.id, arg2);
        assert!(v0.status == 1, 8);
        v0.status = 0;
        v0.requested_ts_ms = 0;
        let v1 = RedemptionRejected{
            cert_id : 0x2::object::id<SpiceCertificate>(&v0),
            serial  : v0.serial,
            holder  : v0.holder,
            reason  : arg3,
        };
        0x2::event::emit<RedemptionRejected>(v1);
        0x2::transfer::transfer<SpiceCertificate>(v0, v0.holder);
    }

    public fun request_redemption(arg0: &Issuer, arg1: SpiceCertificate, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.holder == 0x2::tx_context::sender(arg4), 6);
        assert!(arg1.status == 0, 7);
        assert!(arg2 == 0 || arg2 == 1, 9);
        arg1.status = 1;
        arg1.payout_asset = arg2;
        arg1.requested_ts_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = RedemptionRequested{
            cert_id         : 0x2::object::id<SpiceCertificate>(&arg1),
            serial          : arg1.serial,
            holder          : arg1.holder,
            payout_asset    : arg2,
            requested_ts_ms : arg1.requested_ts_ms,
        };
        0x2::event::emit<RedemptionRequested>(v0);
        0x2::transfer::transfer<SpiceCertificate>(arg1, 0x2::object::id_address<Issuer>(arg0));
    }

    public fun revoke_mint_cap(arg0: &AdminCap, arg1: &mut Issuer, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.mint_caps, &arg2);
        let v0 = MintCapRevoked{cap_id: arg2};
        0x2::event::emit<MintCapRevoked>(v0);
    }

    public fun serial(arg0: &SpiceCertificate) : u64 {
        arg0.serial
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Issuer, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedSet{paused: arg2};
        0x2::event::emit<PausedSet>(v0);
    }

    public fun set_payee(arg0: &AdminCap, arg1: &mut Issuer, arg2: address) {
        assert!(arg2 != @0x0, 15);
        let v0 = PayeeChanged{
            old : arg1.payee,
            new : arg2,
        };
        0x2::event::emit<PayeeChanged>(v0);
        arg1.payee = arg2;
    }

    public fun set_template_allowed(arg0: &AdminCap, arg1: &mut Issuer, arg2: 0x1::string::String, arg3: bool) {
        if (arg3) {
            if (!0x2::vec_set::contains<0x1::string::String>(&arg1.allowed_templates, &arg2)) {
                0x2::vec_set::insert<0x1::string::String>(&mut arg1.allowed_templates, arg2);
            };
        } else if (0x2::vec_set::contains<0x1::string::String>(&arg1.allowed_templates, &arg2)) {
            0x2::vec_set::remove<0x1::string::String>(&mut arg1.allowed_templates, &arg2);
        };
        let v0 = TemplateAllowed{
            template_id : arg2,
            allowed     : arg3,
        };
        0x2::event::emit<TemplateAllowed>(v0);
    }

    public fun status(arg0: &SpiceCertificate) : u8 {
        arg0.status
    }

    public fun template_allowed(arg0: &Issuer, arg1: 0x1::string::String) : bool {
        0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_templates, &arg1)
    }

    // decompiled from Move bytecode v7
}

