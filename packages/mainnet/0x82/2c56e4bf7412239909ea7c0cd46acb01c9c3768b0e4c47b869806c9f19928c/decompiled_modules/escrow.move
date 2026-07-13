module 0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::escrow {
    struct BookingEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        booking_ref: 0x1::string::String,
        guest: address,
        host: address,
        arbitrator: address,
        amount: u64,
        coin: 0x2::coin::Coin<T0>,
        expiry_ms: u64,
        status: u8,
        claim_amount: u64,
    }

    struct BookingPaymentEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        booking_ref: 0x1::string::String,
        guest: address,
        host: address,
        aria_addr: address,
        tax_addr: address,
        arbitrator: address,
        host_amount: u64,
        aria_amount: u64,
        tax_amount: u64,
        coin: 0x2::coin::Coin<T0>,
        release_time_ms: u64,
        status: u8,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        guest: address,
        host: address,
        amount: u64,
        expiry_ms: u64,
    }

    struct DepositReleased has copy, drop {
        escrow_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        guest: address,
        guest_amount: u64,
        host_amount: u64,
    }

    struct DamageClaimed has copy, drop {
        escrow_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        host: address,
        claim_amount: u64,
    }

    struct ClaimDisputed has copy, drop {
        escrow_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        guest: address,
    }

    struct DisputeResolved has copy, drop {
        escrow_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        guest_amount: u64,
        host_amount: u64,
    }

    struct PaymentEscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        guest: address,
        host: address,
        host_amount: u64,
        aria_amount: u64,
        tax_amount: u64,
        release_time_ms: u64,
    }

    struct PaymentReleased has copy, drop {
        escrow_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        host_amount: u64,
        aria_amount: u64,
        tax_amount: u64,
    }

    struct PaymentRefunded has copy, drop {
        escrow_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        guest: address,
        amount: u64,
    }

    struct BookingPass has key {
        id: 0x2::object::UID,
        booking_ref: 0x1::string::String,
        guest: address,
        host: address,
        property_id: u64,
        check_in_ms: u64,
        check_out_ms: u64,
    }

    struct BookingPassMinted has copy, drop {
        pass_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        guest: address,
        host: address,
    }

    struct ResalePolicy has key {
        id: 0x2::object::UID,
        booking_ref: 0x1::string::String,
        host: address,
        transferable: bool,
        max_premium_bps: u64,
        resale_count: u8,
        release_time_ms: u64,
        resale_window_ms: u64,
        property_id: u64,
        check_in_ms: u64,
        check_out_ms: u64,
        listed: bool,
        ask_price: u64,
        seller: address,
    }

    struct ResalePolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        booking_ref: 0x1::string::String,
        host: address,
        transferable: bool,
        max_premium_bps: u64,
    }

    struct ResaleListed has copy, drop {
        booking_ref: 0x1::string::String,
        seller: address,
        ask_price: u64,
        face: u64,
    }

    struct ResaleCancelled has copy, drop {
        booking_ref: 0x1::string::String,
        seller: address,
    }

    struct BookingResold has copy, drop {
        booking_ref: 0x1::string::String,
        seller: address,
        buyer: address,
        sale_price: u64,
        face: u64,
        aria_cut: u64,
        host_cut: u64,
        seller_cut: u64,
    }

    struct IdentityIssuer has key {
        id: 0x2::object::UID,
        admin: address,
        issuer: address,
    }

    struct IdentityAttestation has key {
        id: 0x2::object::UID,
        holder: address,
        expires_ms: u64,
    }

    struct IdentityIssuerCreated has copy, drop {
        issuer_id: 0x2::object::ID,
        admin: address,
        issuer: address,
    }

    struct IdentityAttested has copy, drop {
        attestation_id: 0x2::object::ID,
        holder: address,
        expires_ms: u64,
    }

    public fun accept_claim<T0>(arg0: BookingEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 6);
        assert!(0x2::tx_context::sender(arg1) == arg0.guest, 0);
        let v0 = arg0.guest;
        let v1 = arg0.amount;
        let v2 = arg0.claim_amount;
        let BookingEscrow {
            id           : v3,
            booking_ref  : _,
            guest        : _,
            host         : _,
            arbitrator   : _,
            amount       : _,
            coin         : v9,
            expiry_ms    : _,
            status       : _,
            claim_amount : _,
        } = arg0;
        let v13 = v3;
        0x2::object::delete(v13);
        let v14 = v9;
        let v15 = v1 - v2;
        if (v2 > 0 && v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v14, v2, arg1), arg0.host);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v0);
        } else if (v2 == v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, arg0.host);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v0);
        };
        let v16 = DepositReleased{
            escrow_id    : 0x2::object::uid_to_inner(&v13),
            booking_ref  : arg0.booking_ref,
            guest        : v0,
            guest_amount : v15,
            host_amount  : v2,
        };
        0x2::event::emit<DepositReleased>(v16);
    }

    public fun amount<T0>(arg0: &BookingEscrow<T0>) : u64 {
        arg0.amount
    }

    public fun arbitrator<T0>(arg0: &BookingEscrow<T0>) : address {
        arg0.arbitrator
    }

    public fun attestation_expires_ms(arg0: &IdentityAttestation) : u64 {
        arg0.expires_ms
    }

    public fun attestation_holder(arg0: &IdentityAttestation) : address {
        arg0.holder
    }

    public fun auto_release<T0>(arg0: BookingEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms, 3);
        let v0 = arg0.guest;
        let BookingEscrow {
            id           : v1,
            booking_ref  : _,
            guest        : _,
            host         : _,
            arbitrator   : _,
            amount       : _,
            coin         : v7,
            expiry_ms    : _,
            status       : _,
            claim_amount : _,
        } = arg0;
        let v11 = v1;
        0x2::object::delete(v11);
        let v12 = DepositReleased{
            escrow_id    : 0x2::object::uid_to_inner(&v11),
            booking_ref  : arg0.booking_ref,
            guest        : v0,
            guest_amount : arg0.amount,
            host_amount  : 0,
        };
        0x2::event::emit<DepositReleased>(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v0);
    }

    public fun booking_ref<T0>(arg0: &BookingEscrow<T0>) : 0x1::string::String {
        arg0.booking_ref
    }

    public fun buy_resale<T0>(arg0: &mut BookingEscrow<T0>, arg1: &mut BookingPaymentEscrow<T0>, arg2: &mut ResalePolicy, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 28
    }

    public fun buy_resale_verified<T0>(arg0: &mut BookingEscrow<T0>, arg1: &mut BookingPaymentEscrow<T0>, arg2: &mut ResalePolicy, arg3: &IdentityAttestation, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg3.holder == v0, 26);
        assert!(0x2::clock::timestamp_ms(arg5) < arg3.expires_ms, 25);
        assert!(arg2.listed, 20);
        assert!(arg2.booking_ref == arg0.booking_ref, 19);
        assert!(arg2.booking_ref == arg1.booking_ref, 19);
        assert!(arg0.status == 0, 6);
        assert!(arg1.status == 0, 6);
        assert!(0x2::clock::timestamp_ms(arg5) + arg2.resale_window_ms < arg2.release_time_ms, 16);
        let v1 = 0x2::coin::value<T0>(&arg4);
        assert!(v1 == arg2.ask_price, 21);
        let v2 = arg0.amount + arg1.host_amount + arg1.aria_amount + arg1.tax_amount;
        assert!(v1 >= v2, 18);
        let v3 = v1 - v2;
        let v4 = (((v3 as u128) * (1000 as u128) / (10000 as u128)) as u64);
        let v5 = (((v3 as u128) * (4500 as u128) / (10000 as u128)) as u64);
        let v6 = arg0.guest;
        arg0.guest = v0;
        arg1.guest = v0;
        arg2.resale_count = arg2.resale_count + 1;
        arg2.listed = false;
        arg2.ask_price = 0;
        arg2.seller = @0x0;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v4, arg6), arg1.aria_addr);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v5, arg6), arg1.host);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v6);
        mint_booking_pass(arg2.booking_ref, v0, arg2.host, arg2.property_id, arg2.check_in_ms, arg2.check_out_ms, arg6);
        let v7 = BookingResold{
            booking_ref : arg2.booking_ref,
            seller      : v6,
            buyer       : v0,
            sale_price  : v1,
            face        : v2,
            aria_cut    : v4,
            host_cut    : v5,
            seller_cut  : v1 - v4 - v5,
        };
        0x2::event::emit<BookingResold>(v7);
    }

    public fun cancel_resale_listing(arg0: &mut ResalePolicy, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.listed, 20);
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 0);
        let v0 = arg0.seller;
        arg0.listed = false;
        arg0.ask_price = 0;
        arg0.seller = @0x0;
        mint_booking_pass(arg0.booking_ref, v0, arg0.host, arg0.property_id, arg0.check_in_ms, arg0.check_out_ms, arg1);
        let v1 = ResaleCancelled{
            booking_ref : arg0.booking_ref,
            seller      : v0,
        };
        0x2::event::emit<ResaleCancelled>(v1);
    }

    public fun claim_amount<T0>(arg0: &BookingEscrow<T0>) : u64 {
        arg0.claim_amount
    }

    public fun claim_damage<T0>(arg0: &mut BookingEscrow<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 6);
        assert!(0x2::tx_context::sender(arg3) == arg0.host, 1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expiry_ms, 4);
        assert!(arg1 > 0, 7);
        assert!(arg1 <= arg0.amount, 5);
        arg0.status = 2;
        arg0.claim_amount = arg1;
        let v0 = DamageClaimed{
            escrow_id    : 0x2::object::id<BookingEscrow<T0>>(arg0),
            booking_ref  : arg0.booking_ref,
            host         : arg0.host,
            claim_amount : arg1,
        };
        0x2::event::emit<DamageClaimed>(v0);
    }

    public fun create_escrow<T0>(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 > 0, 7);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg6), 9);
        assert!(arg4 <= 0x2::clock::timestamp_ms(arg6) + 34560000000, 10);
        assert!(arg3 != arg1 && arg3 != arg2, 23);
        let v1 = BookingEscrow<T0>{
            id           : 0x2::object::new(arg7),
            booking_ref  : arg0,
            guest        : arg1,
            host         : arg2,
            arbitrator   : arg3,
            amount       : v0,
            coin         : arg5,
            expiry_ms    : arg4,
            status       : 0,
            claim_amount : 0,
        };
        let v2 = EscrowCreated{
            escrow_id   : 0x2::object::id<BookingEscrow<T0>>(&v1),
            booking_ref : v1.booking_ref,
            guest       : v1.guest,
            host        : v1.host,
            amount      : v1.amount,
            expiry_ms   : v1.expiry_ms,
        };
        0x2::event::emit<EscrowCreated>(v2);
        0x2::transfer::share_object<BookingEscrow<T0>>(v1);
    }

    public fun create_payment_escrow<T0>(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::coin::Coin<T0>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg10);
        assert!(v0 > 0, 7);
        assert!(arg6 + arg7 + arg8 == v0, 8);
        assert!(arg9 > 0x2::clock::timestamp_ms(arg11), 13);
        assert!(arg9 <= 0x2::clock::timestamp_ms(arg11) + 34560000000, 30);
        assert!(arg5 != arg1 && arg5 != arg2, 23);
        let v1 = BookingPaymentEscrow<T0>{
            id              : 0x2::object::new(arg12),
            booking_ref     : arg0,
            guest           : arg1,
            host            : arg2,
            aria_addr       : arg3,
            tax_addr        : arg4,
            arbitrator      : arg5,
            host_amount     : arg6,
            aria_amount     : arg7,
            tax_amount      : arg8,
            coin            : arg10,
            release_time_ms : arg9,
            status          : 0,
        };
        let v2 = PaymentEscrowCreated{
            escrow_id       : 0x2::object::id<BookingPaymentEscrow<T0>>(&v1),
            booking_ref     : v1.booking_ref,
            guest           : v1.guest,
            host            : v1.host,
            host_amount     : v1.host_amount,
            aria_amount     : v1.aria_amount,
            tax_amount      : v1.tax_amount,
            release_time_ms : v1.release_time_ms,
        };
        0x2::event::emit<PaymentEscrowCreated>(v2);
        0x2::transfer::share_object<BookingPaymentEscrow<T0>>(v1);
    }

    public fun create_resale_policy(arg0: 0x1::string::String, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = ResalePolicy{
            id               : 0x2::object::new(arg9),
            booking_ref      : arg0,
            host             : arg1,
            transferable     : arg2,
            max_premium_bps  : arg3,
            resale_count     : 0,
            release_time_ms  : arg4,
            resale_window_ms : arg5,
            property_id      : arg6,
            check_in_ms      : arg7,
            check_out_ms     : arg8,
            listed           : false,
            ask_price        : 0,
            seller           : @0x0,
        };
        let v1 = ResalePolicyCreated{
            policy_id       : 0x2::object::id<ResalePolicy>(&v0),
            booking_ref     : v0.booking_ref,
            host            : v0.host,
            transferable    : v0.transferable,
            max_premium_bps : v0.max_premium_bps,
        };
        0x2::event::emit<ResalePolicyCreated>(v1);
        0x2::transfer::share_object<ResalePolicy>(v0);
    }

    public fun default_resale_window_ms() : u64 {
        172800000
    }

    public fun dispute_claim<T0>(arg0: &mut BookingEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 6);
        assert!(0x2::tx_context::sender(arg1) == arg0.guest, 0);
        arg0.status = 3;
        let v0 = ClaimDisputed{
            escrow_id   : 0x2::object::id<BookingEscrow<T0>>(arg0),
            booking_ref : arg0.booking_ref,
            guest       : arg0.guest,
        };
        0x2::event::emit<ClaimDisputed>(v0);
    }

    public fun expiry_ms<T0>(arg0: &BookingEscrow<T0>) : u64 {
        arg0.expiry_ms
    }

    public fun finalize_claim<T0>(arg0: BookingEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms, 3);
        let v0 = arg0.guest;
        let v1 = arg0.amount;
        let v2 = arg0.claim_amount;
        let BookingEscrow {
            id           : v3,
            booking_ref  : _,
            guest        : _,
            host         : _,
            arbitrator   : _,
            amount       : _,
            coin         : v9,
            expiry_ms    : _,
            status       : _,
            claim_amount : _,
        } = arg0;
        let v13 = v3;
        0x2::object::delete(v13);
        let v14 = v9;
        let v15 = v1 - v2;
        if (v2 > 0 && v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v14, v2, arg2), arg0.host);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v0);
        } else if (v2 == v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, arg0.host);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v0);
        };
        let v16 = DepositReleased{
            escrow_id    : 0x2::object::uid_to_inner(&v13),
            booking_ref  : arg0.booking_ref,
            guest        : v0,
            guest_amount : v15,
            host_amount  : v2,
        };
        0x2::event::emit<DepositReleased>(v16);
    }

    public fun five_days_ms() : u64 {
        432000000
    }

    public fun guest<T0>(arg0: &BookingEscrow<T0>) : address {
        arg0.guest
    }

    public fun host<T0>(arg0: &BookingEscrow<T0>) : address {
        arg0.host
    }

    public fun init_identity_issuer(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = IdentityIssuer{
            id     : 0x2::object::new(arg2),
            admin  : arg0,
            issuer : arg1,
        };
        let v1 = IdentityIssuerCreated{
            issuer_id : 0x2::object::id<IdentityIssuer>(&v0),
            admin     : arg0,
            issuer    : arg1,
        };
        0x2::event::emit<IdentityIssuerCreated>(v1);
        0x2::transfer::share_object<IdentityIssuer>(v0);
    }

    public fun issuer_addr(arg0: &IdentityIssuer) : address {
        arg0.issuer
    }

    public fun issuer_admin(arg0: &IdentityIssuer) : address {
        arg0.admin
    }

    public fun list_for_resale<T0>(arg0: &mut BookingEscrow<T0>, arg1: &mut BookingPaymentEscrow<T0>, arg2: &mut ResalePolicy, arg3: BookingPass, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg0.guest, 0);
        assert!(v0 == arg1.guest, 0);
        assert!(v0 == arg3.guest, 0);
        assert!(arg2.booking_ref == arg0.booking_ref, 19);
        assert!(arg2.booking_ref == arg1.booking_ref, 19);
        assert!(arg2.booking_ref == arg3.booking_ref, 19);
        assert!(arg0.status == 0, 6);
        assert!(arg1.status == 0, 6);
        assert!(!arg2.listed, 22);
        assert!(arg2.transferable, 14);
        assert!((arg2.resale_count as u64) < (1 as u64), 17);
        assert!(0x2::clock::timestamp_ms(arg5) + arg2.resale_window_ms < arg2.release_time_ms, 16);
        let v1 = arg0.amount + arg1.host_amount + arg1.aria_amount + arg1.tax_amount;
        assert!(arg4 >= v1, 18);
        assert!(((arg4 - v1) as u128) * (10000 as u128) <= (v1 as u128) * (arg2.max_premium_bps as u128), 15);
        let BookingPass {
            id           : v2,
            booking_ref  : _,
            guest        : _,
            host         : _,
            property_id  : _,
            check_in_ms  : _,
            check_out_ms : _,
        } = arg3;
        0x2::object::delete(v2);
        arg2.listed = true;
        arg2.ask_price = arg4;
        arg2.seller = v0;
        let v9 = ResaleListed{
            booking_ref : arg2.booking_ref,
            seller      : v0,
            ask_price   : arg4,
            face        : v1,
        };
        0x2::event::emit<ResaleListed>(v9);
    }

    public fun max_expiry_ms() : u64 {
        34560000000
    }

    public fun mint_booking_pass(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = BookingPass{
            id           : 0x2::object::new(arg6),
            booking_ref  : arg0,
            guest        : arg1,
            host         : arg2,
            property_id  : arg3,
            check_in_ms  : arg4,
            check_out_ms : arg5,
        };
        let v1 = BookingPassMinted{
            pass_id     : 0x2::object::id<BookingPass>(&v0),
            booking_ref : v0.booking_ref,
            guest       : v0.guest,
            host        : v0.host,
        };
        0x2::event::emit<BookingPassMinted>(v1);
        0x2::transfer::transfer<BookingPass>(v0, arg1);
    }

    public fun mint_identity_attestation(arg0: &IdentityIssuer, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.issuer, 24);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg3), 9);
        let v0 = IdentityAttestation{
            id         : 0x2::object::new(arg4),
            holder     : arg1,
            expires_ms : arg2,
        };
        let v1 = IdentityAttested{
            attestation_id : 0x2::object::id<IdentityAttestation>(&v0),
            holder         : arg1,
            expires_ms     : arg2,
        };
        0x2::event::emit<IdentityAttested>(v1);
        0x2::transfer::transfer<IdentityAttestation>(v0, arg1);
    }

    public fun pass_booking_ref(arg0: &BookingPass) : 0x1::string::String {
        arg0.booking_ref
    }

    public fun pass_check_in_ms(arg0: &BookingPass) : u64 {
        arg0.check_in_ms
    }

    public fun pass_check_out_ms(arg0: &BookingPass) : u64 {
        arg0.check_out_ms
    }

    public fun pass_guest(arg0: &BookingPass) : address {
        arg0.guest
    }

    public fun pass_host(arg0: &BookingPass) : address {
        arg0.host
    }

    public fun pass_property_id(arg0: &BookingPass) : u64 {
        arg0.property_id
    }

    public fun payment_arbitrator<T0>(arg0: &BookingPaymentEscrow<T0>) : address {
        arg0.arbitrator
    }

    public fun payment_aria_addr<T0>(arg0: &BookingPaymentEscrow<T0>) : address {
        arg0.aria_addr
    }

    public fun payment_aria_amount<T0>(arg0: &BookingPaymentEscrow<T0>) : u64 {
        arg0.aria_amount
    }

    public fun payment_booking_ref<T0>(arg0: &BookingPaymentEscrow<T0>) : 0x1::string::String {
        arg0.booking_ref
    }

    public fun payment_guest<T0>(arg0: &BookingPaymentEscrow<T0>) : address {
        arg0.guest
    }

    public fun payment_host<T0>(arg0: &BookingPaymentEscrow<T0>) : address {
        arg0.host
    }

    public fun payment_host_amount<T0>(arg0: &BookingPaymentEscrow<T0>) : u64 {
        arg0.host_amount
    }

    public fun payment_release_time_ms<T0>(arg0: &BookingPaymentEscrow<T0>) : u64 {
        arg0.release_time_ms
    }

    public fun payment_status<T0>(arg0: &BookingPaymentEscrow<T0>) : u8 {
        arg0.status
    }

    public fun payment_tax_addr<T0>(arg0: &BookingPaymentEscrow<T0>) : address {
        arg0.tax_addr
    }

    public fun payment_tax_amount<T0>(arg0: &BookingPaymentEscrow<T0>) : u64 {
        arg0.tax_amount
    }

    public fun policy_ask_price(arg0: &ResalePolicy) : u64 {
        arg0.ask_price
    }

    public fun policy_booking_ref(arg0: &ResalePolicy) : 0x1::string::String {
        arg0.booking_ref
    }

    public fun policy_check_in_ms(arg0: &ResalePolicy) : u64 {
        arg0.check_in_ms
    }

    public fun policy_check_out_ms(arg0: &ResalePolicy) : u64 {
        arg0.check_out_ms
    }

    public fun policy_host(arg0: &ResalePolicy) : address {
        arg0.host
    }

    public fun policy_listed(arg0: &ResalePolicy) : bool {
        arg0.listed
    }

    public fun policy_max_premium_bps(arg0: &ResalePolicy) : u64 {
        arg0.max_premium_bps
    }

    public fun policy_property_id(arg0: &ResalePolicy) : u64 {
        arg0.property_id
    }

    public fun policy_release_time_ms(arg0: &ResalePolicy) : u64 {
        arg0.release_time_ms
    }

    public fun policy_resale_count(arg0: &ResalePolicy) : u8 {
        arg0.resale_count
    }

    public fun policy_resale_window_ms(arg0: &ResalePolicy) : u64 {
        arg0.resale_window_ms
    }

    public fun policy_seller(arg0: &ResalePolicy) : address {
        arg0.seller
    }

    public fun policy_transferable(arg0: &ResalePolicy) : bool {
        arg0.transferable
    }

    public fun refund_deposit<T0>(arg0: BookingEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 6);
        assert!(0x2::tx_context::sender(arg1) == arg0.arbitrator, 2);
        let v0 = arg0.guest;
        let BookingEscrow {
            id           : v1,
            booking_ref  : _,
            guest        : _,
            host         : _,
            arbitrator   : _,
            amount       : _,
            coin         : v7,
            expiry_ms    : _,
            status       : _,
            claim_amount : _,
        } = arg0;
        let v11 = v1;
        0x2::object::delete(v11);
        let v12 = DepositReleased{
            escrow_id    : 0x2::object::uid_to_inner(&v11),
            booking_ref  : arg0.booking_ref,
            guest        : v0,
            guest_amount : arg0.amount,
            host_amount  : 0,
        };
        0x2::event::emit<DepositReleased>(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v0);
    }

    public fun refund_payment<T0>(arg0: BookingPaymentEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 6);
        assert!(0x2::tx_context::sender(arg2) == arg0.arbitrator, 2);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.release_time_ms, 12);
        let v0 = arg0.guest;
        let BookingPaymentEscrow {
            id              : v1,
            booking_ref     : _,
            guest           : _,
            host            : _,
            aria_addr       : _,
            tax_addr        : _,
            arbitrator      : _,
            host_amount     : _,
            aria_amount     : _,
            tax_amount      : _,
            coin            : v11,
            release_time_ms : _,
            status          : _,
        } = arg0;
        let v14 = v11;
        let v15 = v1;
        0x2::object::delete(v15);
        let v16 = PaymentRefunded{
            escrow_id   : 0x2::object::uid_to_inner(&v15),
            booking_ref : arg0.booking_ref,
            guest       : v0,
            amount      : 0x2::coin::value<T0>(&v14),
        };
        0x2::event::emit<PaymentRefunded>(v16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v0);
    }

    public fun release_payment<T0>(arg0: BookingPaymentEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.release_time_ms, 11);
        let v0 = arg0.host_amount;
        let v1 = arg0.aria_amount;
        let BookingPaymentEscrow {
            id              : v2,
            booking_ref     : _,
            guest           : _,
            host            : _,
            aria_addr       : _,
            tax_addr        : _,
            arbitrator      : _,
            host_amount     : _,
            aria_amount     : _,
            tax_amount      : _,
            coin            : v12,
            release_time_ms : _,
            status          : _,
        } = arg0;
        let v15 = v2;
        0x2::object::delete(v15);
        let v16 = v12;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v16, v0, arg2), arg0.host);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v16, v1, arg2), arg0.aria_addr);
        };
        if (0x2::coin::value<T0>(&v16) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, arg0.tax_addr);
        } else {
            0x2::coin::destroy_zero<T0>(v16);
        };
        let v17 = PaymentReleased{
            escrow_id   : 0x2::object::uid_to_inner(&v15),
            booking_ref : arg0.booking_ref,
            host_amount : v0,
            aria_amount : v1,
            tax_amount  : arg0.tax_amount,
        };
        0x2::event::emit<PaymentReleased>(v17);
    }

    public fun resolve_dispute<T0>(arg0: BookingEscrow<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3, 6);
        assert!(0x2::tx_context::sender(arg3) == arg0.arbitrator, 2);
        assert!(arg1 + arg2 == arg0.amount, 8);
        let BookingEscrow {
            id           : v0,
            booking_ref  : _,
            guest        : _,
            host         : _,
            arbitrator   : _,
            amount       : _,
            coin         : v6,
            expiry_ms    : _,
            status       : _,
            claim_amount : _,
        } = arg0;
        let v10 = v0;
        0x2::object::delete(v10);
        let v11 = v6;
        if (arg2 > 0 && arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v11, arg2, arg3), arg0.host);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, arg0.guest);
        } else if (arg2 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, arg0.guest);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, arg0.host);
        };
        let v12 = DisputeResolved{
            escrow_id    : 0x2::object::uid_to_inner(&v10),
            booking_ref  : arg0.booking_ref,
            guest_amount : arg1,
            host_amount  : arg2,
        };
        0x2::event::emit<DisputeResolved>(v12);
    }

    public fun resolve_stale_dispute<T0>(arg0: BookingEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 3, 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms + 2592000000, 29);
        let v0 = arg0.guest;
        let v1 = arg0.amount;
        let v2 = arg0.claim_amount;
        let BookingEscrow {
            id           : v3,
            booking_ref  : _,
            guest        : _,
            host         : _,
            arbitrator   : _,
            amount       : _,
            coin         : v9,
            expiry_ms    : _,
            status       : _,
            claim_amount : _,
        } = arg0;
        let v13 = v3;
        0x2::object::delete(v13);
        let v14 = v9;
        let v15 = v1 - v2;
        if (v2 > 0 && v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v14, v2, arg2), arg0.host);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v0);
        } else if (v2 == v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, arg0.host);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v0);
        };
        let v16 = DepositReleased{
            escrow_id    : 0x2::object::uid_to_inner(&v13),
            booking_ref  : arg0.booking_ref,
            guest        : v0,
            guest_amount : v15,
            host_amount  : v2,
        };
        0x2::event::emit<DepositReleased>(v16);
    }

    public entry fun seal_approve<T0>(arg0: vector<u8>, arg1: &BookingEscrow<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::address::to_bytes(arg1.guest), 0);
        assert!(0x2::tx_context::sender(arg2) == arg1.host, 1);
    }

    public fun set_issuer(arg0: &mut IdentityIssuer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 27);
        arg0.issuer = arg1;
    }

    public fun status<T0>(arg0: &BookingEscrow<T0>) : u8 {
        arg0.status
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_claimed() : u8 {
        2
    }

    public fun status_disputed() : u8 {
        3
    }

    public fun status_refunded() : u8 {
        5
    }

    public fun status_released() : u8 {
        1
    }

    public fun status_resolved() : u8 {
        4
    }

    // decompiled from Move bytecode v7
}

