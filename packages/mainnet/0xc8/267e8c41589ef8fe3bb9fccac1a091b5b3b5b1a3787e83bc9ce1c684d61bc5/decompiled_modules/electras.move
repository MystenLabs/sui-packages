module 0xc8267e8c41589ef8fe3bb9fccac1a091b5b3b5b1a3787e83bc9ce1c684d61bc5::electras {
    struct ELECTRICITY has store, key {
        id: 0x2::object::UID,
    }

    struct ElectricityReceipt has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct UserMeter has store, key {
        id: 0x2::object::UID,
        meter_id: 0x1::string::String,
        user_address: address,
        unit_per_hour: u64,
        timestamp: u64,
    }

    struct MeterRegistry has store, key {
        id: 0x2::object::UID,
        initial_energy_units: u64,
        total_users: u64,
        owner: address,
        user_meters: 0x2::table::Table<u64, UserMeter>,
        receipts: 0x2::table::Table<u64, ElectricityReceipt>,
    }

    struct MeterAttestation has store {
        user_meter: 0x2::object::ID,
        attestor: address,
        attestor_signature: vector<u8>,
        kwh: u64,
        timestamp: u64,
    }

    struct AttestationRegistry has key {
        id: 0x2::object::UID,
        attestations: 0x2::table::Table<vector<u8>, MeterAttestation>,
    }

    struct EnergyToken has store, key {
        id: 0x2::object::UID,
        amount: u64,
        producer: address,
        attestation: MeterAttestation,
        status: u8,
    }

    struct FraudFlag has store {
        user: address,
        meter_id: 0x1::string::String,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct FraudRegistry has key {
        id: 0x2::object::UID,
        reports: 0x2::table::Table<0x2::object::ID, vector<FraudFlag>>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        price: u64,
        seller: address,
    }

    struct Marketplace<phantom T0> has store {
        items: 0x2::table::Table<0x2::object::ID, Listing>,
        seller_address: address,
        token_quantity: u64,
        price_per_token: u64,
        expiry_time: u64,
        payments: 0x2::table::Table<address, 0x2::coin::Coin<T0>>,
    }

    struct Escrow has store, key {
        id: 0x2::object::UID,
        buyer: address,
        seller: address,
        status: u8,
    }

    struct ProducerRegistry has key {
        id: 0x2::object::UID,
        producers: 0x2::table::Table<address, bool>,
    }

    struct ProductionEvent has copy, drop {
        producer: address,
        attestation_hash: vector<u8>,
        kwh: u64,
        timestamp: u64,
    }

    struct MeterAttestationEvent has copy, drop {
        user_meter: 0x2::object::ID,
        attestor: address,
        kwh: u64,
        timestamp: u64,
    }

    struct ListingEvent has copy, drop {
        token_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct PurchaseEvent has copy, drop {
        dummy_field: bool,
    }

    struct RedeemEvent has copy, drop, store {
        redeemer: address,
        amount: u64,
    }

    struct FraudAlertEvent has copy, drop {
        user: address,
        meter_id: 0x1::string::String,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    public fun attestation_is_valid(arg0: &MeterAttestation, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = serialize_attestation(arg0.user_meter, arg0.kwh, arg0.timestamp);
        if (arg0.attestor == @0x0) {
            return false
        };
        if (arg0.timestamp > arg2) {
            return false
        };
        0x2::ed25519::ed25519_verify(&arg1, &v0, &arg0.attestor_signature)
    }

    public fun buy_listing_tokens<T0: store + key>(arg0: &mut Marketplace<0x2::sui::SUI>, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id     : v0,
            price  : v1,
            seller : v2,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.items, arg2);
        let v3 = v0;
        assert!(v1 == 0x2::coin::value<0x2::sui::SUI>(&arg3), 2);
        if (0x2::table::contains<address, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.payments, v2)) {
            0x2::coin::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.payments, v2), arg3);
        } else {
            0x2::table::add<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.payments, v2, arg3);
        };
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true), arg1);
    }

    public fun flag_fraud(arg0: &mut FraudRegistry, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = FraudFlag{
            user      : arg1,
            meter_id  : arg3,
            reason    : arg4,
            timestamp : arg5,
        };
        if (0x2::table::contains<0x2::object::ID, vector<FraudFlag>>(&arg0.reports, arg2)) {
            0x1::vector::push_back<FraudFlag>(0x2::table::borrow_mut<0x2::object::ID, vector<FraudFlag>>(&mut arg0.reports, arg2), v0);
        } else {
            let v1 = 0x1::vector::empty<FraudFlag>();
            0x1::vector::push_back<FraudFlag>(&mut v1, v0);
            0x2::table::add<0x2::object::ID, vector<FraudFlag>>(&mut arg0.reports, arg2, v1);
        };
        let v2 = FraudAlertEvent{
            user      : v0.user,
            meter_id  : arg3,
            reason    : arg4,
            timestamp : v0.timestamp,
        };
        0x2::event::emit<FraudAlertEvent>(v2);
    }

    public fun init_registry(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : MeterRegistry {
        MeterRegistry{
            id                   : 0x2::object::new(arg1),
            initial_energy_units : arg0,
            total_users          : 0,
            owner                : 0x2::tx_context::sender(arg1),
            user_meters          : 0x2::table::new<u64, UserMeter>(arg1),
            receipts             : 0x2::table::new<u64, ElectricityReceipt>(arg1),
        }
    }

    public fun is_producer(arg0: &ProducerRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::table::contains<address, bool>(&arg0.producers, arg1);
        assert!(v0, 3);
        v0
    }

    public fun list_tokens<T0: store + key>(arg0: &mut Marketplace<0x2::sui::SUI>, arg1: T0, arg2: 0x2::object::UID, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Listing{
            id     : 0x2::object::new(arg6),
            price  : arg4,
            seller : arg5,
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v0.id, true, arg1);
        0x2::table::add<0x2::object::ID, Listing>(&mut arg0.items, 0x2::object::uid_to_inner(&arg2), v0);
        let v1 = ListingEvent{
            token_id : 0x2::object::uid_to_inner(&arg2),
            price    : arg4,
            seller   : arg5,
        };
        0x2::event::emit<ListingEvent>(v1);
        0x2::object::delete(arg2);
    }

    public fun mint_by_attestation(arg0: &mut AttestationRegistry, arg1: &ProducerRegistry, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::remove<vector<u8>, MeterAttestation>(&mut arg0.attestations, arg2);
        assert!(attestation_is_valid(&v0, arg2, arg4, arg5), 1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(is_producer(arg1, v1, arg5), 3);
        let v2 = EnergyToken{
            id          : 0x2::object::new(arg5),
            amount      : arg3,
            producer    : v1,
            attestation : v0,
            status      : 0,
        };
        0x2::transfer::public_transfer<EnergyToken>(v2, v1);
        let v3 = ProductionEvent{
            producer         : v1,
            attestation_hash : v2.attestation.attestor_signature,
            kwh              : v2.attestation.kwh,
            timestamp        : v2.attestation.timestamp,
        };
        0x2::event::emit<ProductionEvent>(v3);
    }

    public fun mint_electricity(arg0: &mut 0x2::coin::TreasuryCap<ELECTRICITY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ELECTRICITY> {
        0x2::coin::mint<ELECTRICITY>(arg0, arg1, arg2)
    }

    public fun post_attestation(arg0: &MeterAttestation, arg1: 0x2::object::UID, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>) : bool {
        let v0 = serialize_attestation(arg0.user_meter, arg0.kwh, arg0.timestamp);
        let v1 = arg0.attestor == arg2 && 0x2::ed25519::ed25519_verify(&arg5, &v0, &arg0.attestor_signature);
        let v2 = MeterAttestationEvent{
            user_meter : 0x2::object::uid_to_inner(&arg1),
            attestor   : arg2,
            kwh        : arg3,
            timestamp  : arg4,
        };
        0x2::event::emit<MeterAttestationEvent>(v2);
        0x2::object::delete(arg1);
        v1
    }

    public fun redeem_electricity(arg0: &mut 0x2::coin::TreasuryCap<ELECTRICITY>, arg1: 0x2::coin::Coin<ELECTRICITY>, arg2: &mut 0x2::tx_context::TxContext) : ElectricityReceipt {
        0x2::coin::burn<ELECTRICITY>(arg0, arg1);
        ElectricityReceipt{
            id     : 0x2::object::new(arg2),
            amount : 0x2::coin::value<ELECTRICITY>(&arg1),
        }
    }

    public fun register_user(arg0: &mut MeterRegistry, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u64, UserMeter>(&arg0.user_meters, arg5), 4);
        arg0.total_users = arg0.total_users + 1;
        let v0 = UserMeter{
            id            : 0x2::object::new(arg6),
            meter_id      : arg1,
            user_address  : arg4,
            unit_per_hour : arg2,
            timestamp     : arg3,
        };
        let v1 = ElectricityReceipt{
            id     : 0x2::object::new(arg6),
            amount : 20,
        };
        0x2::table::add<u64, UserMeter>(&mut arg0.user_meters, arg5, v0);
        0x2::table::add<u64, ElectricityReceipt>(&mut arg0.receipts, arg5, v1);
    }

    fun serialize_attestation(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun set_initial_energy_units(arg0: &mut MeterRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        arg0.initial_energy_units = arg1;
    }

    public fun top_up_energy(arg0: &mut MeterRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        arg0.initial_energy_units = arg0.initial_energy_units + arg1;
    }

    public fun transfer_energy(arg0: &mut MeterRegistry, arg1: &mut MeterRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.initial_energy_units >= arg2, 1);
        arg0.initial_energy_units = arg0.initial_energy_units - arg2;
        arg1.initial_energy_units = arg1.initial_energy_units + arg2;
    }

    // decompiled from Move bytecode v6
}

