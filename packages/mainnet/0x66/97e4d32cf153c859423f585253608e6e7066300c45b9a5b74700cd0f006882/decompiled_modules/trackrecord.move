module 0xc2989eb04c553a3b89f6c383c54c0607e6229fee181f58de8a25e0fdd6fc6d95::trackrecord {
    struct TRACKRECORD has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PublisherCap has store, key {
        id: 0x2::object::UID,
    }

    struct Founder has drop {
        dummy_field: bool,
    }

    struct FirstLight has drop {
        dummy_field: bool,
    }

    struct Live has drop {
        dummy_field: bool,
    }

    struct Pass<phantom T0> has store, key {
        id: 0x2::object::UID,
        serial: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        minted_at: u64,
        expires_at: u64,
    }

    struct Head has copy, drop, store {
        record: 0x2::object::ID,
        day: u64,
        sequence: u64,
        revision: u64,
        hash: vector<u8>,
    }

    struct Service has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        admin: 0x2::object::ID,
        publisher: 0x2::object::ID,
        reserves: u64,
        gifts: u64,
        lives: u64,
        heads: 0x2::table::Table<u8, Head>,
    }

    struct Record has key {
        id: 0x2::object::UID,
        service: 0x2::object::ID,
        stream: u8,
        day: u64,
        sequence: u64,
        revision: u64,
        commitment: vector<u8>,
        cipher: vector<u8>,
        cipher_hash: vector<u8>,
        previous: vector<u8>,
        record_hash: vector<u8>,
        published_at: u64,
    }

    struct WeeklyReturn has key {
        id: 0x2::object::UID,
        service: 0x2::object::ID,
        stream: u8,
        week_end: u64,
        record_day: u64,
        return_bp: u64,
        negative: bool,
        through_record: vector<u8>,
        inputs_hash: vector<u8>,
        published_at: u64,
    }

    struct RecordKey has copy, drop, store {
        pos0: u8,
        pos1: u64,
    }

    struct FirstLightPass has key {
        id: 0x2::object::UID,
        serial: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        minted_at: u64,
    }

    struct FirstLightKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FirstLightState has store {
        minted: u64,
        return_to: address,
    }

    struct UnlockKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct Unlock has drop, store {
        granted_at: u64,
    }

    struct ServiceCreated has copy, drop {
        service: 0x2::object::ID,
        admin: 0x2::object::ID,
        publisher: 0x2::object::ID,
    }

    struct RecordPublished has copy, drop {
        record: 0x2::object::ID,
        stream: u8,
        day: u64,
        sequence: u64,
        revision: u64,
        record_hash: vector<u8>,
    }

    struct WeeklyReturnCommitted has copy, drop {
        weekly: 0x2::object::ID,
        stream: u8,
        week_end: u64,
        return_bp: u64,
        negative: bool,
    }

    struct PassMinted has copy, drop {
        pass: 0x2::object::ID,
        tier: u8,
        serial: u64,
        expires_at: u64,
    }

    struct AdminRotated has copy, drop {
        old: 0x2::object::ID,
        new: 0x2::object::ID,
    }

    struct PublisherRotated has copy, drop {
        old: 0x2::object::ID,
        new: 0x2::object::ID,
    }

    struct PauseChanged has copy, drop {
        paused: bool,
    }

    struct ServiceMigrated has copy, drop {
        from: u64,
        to: u64,
    }

    struct FirstLightMinted has copy, drop {
        pass: 0x2::object::ID,
        serial: u64,
        to: address,
    }

    struct FirstLightGifted has copy, drop {
        pass: 0x2::object::ID,
        serial: u64,
        to: address,
    }

    struct FirstLightReturned has copy, drop {
        pass: 0x2::object::ID,
        serial: u64,
        from: address,
        to: address,
    }

    struct ReturnAddressSet has copy, drop {
        to: address,
    }

    struct DiversifierUnlocked has copy, drop {
        pass: 0x2::object::ID,
        granted_at: u64,
    }

    struct DiversifierRevoked has copy, drop {
        pass: 0x2::object::ID,
    }

    fun admin_check(arg0: &Service, arg1: &AdminCap) {
        assert!(arg0.version == 2, 13906835046222331914);
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin, 13906835050517561358);
    }

    public fun chain_hash(arg0: vector<u8>, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) : vector<u8> {
        0x1::vector::push_back<u8>(&mut arg0, arg1);
        0x1::vector::append<u8>(&mut arg0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut arg0, arg3);
        0x1::vector::append<u8>(&mut arg0, arg4);
        0x1::hash::sha2_256(arg0)
    }

    public fun commit_weekly_return(arg0: &Service, arg1: &PublisherCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        publisher_check(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg8) == 32, 13906835381230436372);
        assert!(arg4 >= arg3, 13906835385525665816);
        let v0 = RecordKey{
            pos0 : arg2,
            pos1 : arg4,
        };
        assert!(0x2::dynamic_field::exists<RecordKey>(&arg0.id, v0), 13906835394115862556);
        assert!(*0x2::dynamic_field::borrow<RecordKey, vector<u8>>(&arg0.id, v0) == arg7, 13906835398410960926);
        let v1 = arg6 && arg5 > 0;
        let v2 = WeeklyReturn{
            id             : 0x2::object::new(arg10),
            service        : 0x2::object::id<Service>(arg0),
            stream         : arg2,
            week_end       : arg3,
            record_day     : arg4,
            return_bp      : arg5,
            negative       : v1,
            through_record : arg7,
            inputs_hash    : arg8,
            published_at   : 0x2::clock::timestamp_ms(arg9),
        };
        let v3 = 0x2::object::id<WeeklyReturn>(&v2);
        let v4 = WeeklyReturnCommitted{
            weekly    : v3,
            stream    : arg2,
            week_end  : arg3,
            return_bp : arg5,
            negative  : v2.negative,
        };
        0x2::event::emit<WeeklyReturnCommitted>(v4);
        0x2::transfer::freeze_object<WeeklyReturn>(v2);
        v3
    }

    public fun diversifier_unlocked(arg0: &Service, arg1: 0x2::object::ID) : bool {
        let v0 = UnlockKey{pos0: arg1};
        0x2::dynamic_field::exists<UnlockKey>(&arg0.id, v0)
    }

    public fun expires_at<T0>(arg0: &Pass<T0>) : u64 {
        arg0.expires_at
    }

    public fun first_light_minted(arg0: &Service) : u64 {
        let v0 = FirstLightKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FirstLightKey>(&arg0.id, v0)) {
            let v2 = FirstLightKey{dummy_field: false};
            0x2::dynamic_field::borrow<FirstLightKey, FirstLightState>(&arg0.id, v2).minted
        } else {
            0
        }
    }

    public fun first_light_supply() : u64 {
        15
    }

    public fun fl_minted_at(arg0: &FirstLightPass) : u64 {
        arg0.minted_at
    }

    public fun fl_serial(arg0: &FirstLightPass) : u64 {
        arg0.serial
    }

    public fun gift(arg0: &Service, arg1: &AdminCap, arg2: FirstLightPass, arg3: address) {
        admin_check(arg0, arg1);
        assert!(!arg0.paused, 13906835690467557388);
        let v0 = FirstLightGifted{
            pass   : 0x2::object::id<FirstLightPass>(&arg2),
            serial : arg2.serial,
            to     : arg3,
        };
        0x2::event::emit<FirstLightGifted>(v0);
        0x2::transfer::transfer<FirstLightPass>(arg2, arg3);
    }

    public fun grant_diversifier(arg0: &mut Service, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        admin_check(arg0, arg1);
        let v0 = UnlockKey{pos0: arg2};
        assert!(!0x2::dynamic_field::exists<UnlockKey>(&arg0.id, v0), 13906835849383313450);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = UnlockKey{pos0: arg2};
        let v3 = Unlock{granted_at: v1};
        0x2::dynamic_field::add<UnlockKey, Unlock>(&mut arg0.id, v2, v3);
        let v4 = DiversifierUnlocked{
            pass       : arg2,
            granted_at : v1,
        };
        0x2::event::emit<DiversifierUnlocked>(v4);
    }

    public fun head(arg0: &Service, arg1: u8) : Head {
        *0x2::table::borrow<u8, Head>(&arg0.heads, arg1)
    }

    public fun head_day(arg0: &Head) : u64 {
        arg0.day
    }

    public fun head_hash(arg0: &Head) : vector<u8> {
        arg0.hash
    }

    public fun head_revision(arg0: &Head) : u64 {
        arg0.revision
    }

    public fun head_sequence(arg0: &Head) : u64 {
        arg0.sequence
    }

    fun init(arg0: TRACKRECORD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = PublisherCap{id: 0x2::object::new(arg1)};
        let v2 = Service{
            id        : 0x2::object::new(arg1),
            version   : 2,
            paused    : false,
            admin     : 0x2::object::id<AdminCap>(&v0),
            publisher : 0x2::object::id<PublisherCap>(&v1),
            reserves  : 0,
            gifts     : 0,
            lives     : 0,
            heads     : 0x2::table::new<u8, Head>(arg1),
        };
        let v3 = ServiceCreated{
            service   : 0x2::object::id<Service>(&v2),
            admin     : v2.admin,
            publisher : v2.publisher,
        };
        0x2::event::emit<ServiceCreated>(v3);
        0x2::transfer::share_object<Service>(v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<TRACKRECORD>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<PublisherCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun live_check(arg0: &Service) {
        assert!(arg0.version == 2, 13906835029042462730);
        assert!(!arg0.paused, 13906835033337561100);
    }

    public fun migrate(arg0: &mut Service, arg1: &AdminCap) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin, 13906836034065072142);
        assert!(arg0.version < 2, 13906836038361350178);
        arg0.version = 2;
        let v0 = ServiceMigrated{
            from : arg0.version,
            to   : 2,
        };
        0x2::event::emit<ServiceMigrated>(v0);
    }

    public fun mint_first_light(arg0: &mut Service, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Pass<FirstLight> {
        abort 13906835505785536548
    }

    public fun mint_first_light_pass(arg0: &mut Service, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg1);
        assert!(!arg0.paused, 13906835626043047948);
        let v0 = FirstLightKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FirstLightKey>(&arg0.id, v0)) {
            let v1 = FirstLightKey{dummy_field: false};
            let v2 = FirstLightState{
                minted    : 0,
                return_to : 0x2::tx_context::sender(arg5),
            };
            0x2::dynamic_field::add<FirstLightKey, FirstLightState>(&mut arg0.id, v1, v2);
        };
        let v3 = FirstLightKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<FirstLightKey, FirstLightState>(&mut arg0.id, v3);
        assert!(v4.minted < 15, 13906835647518801946);
        v4.minted = v4.minted + 1;
        let v5 = FirstLightPass{
            id        : 0x2::object::new(arg5),
            serial    : v4.minted,
            name      : arg2,
            image_url : arg3,
            minted_at : 0x2::clock::timestamp_ms(arg4),
        };
        let v6 = FirstLightMinted{
            pass   : 0x2::object::id<FirstLightPass>(&v5),
            serial : v5.serial,
            to     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<FirstLightMinted>(v6);
        0x2::transfer::transfer<FirstLightPass>(v5, 0x2::tx_context::sender(arg5));
    }

    public fun mint_founder_reserve(arg0: &mut Service, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Pass<Founder> {
        admin_check(arg0, arg1);
        assert!(arg0.reserves < 5, 13906835467130175514);
        arg0.reserves = arg0.reserves + 1;
        new_pass<Founder>(0, 20 + arg0.reserves, arg2, arg3, 0, arg4, arg5)
    }

    public fun mint_live(arg0: &mut Service, arg1: &AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Pass<Live> {
        admin_check(arg0, arg1);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5), 13906835540145012768);
        arg0.lives = arg0.lives + 1;
        new_pass<Live>(2, arg0.lives, arg2, arg3, arg4, arg5, arg6)
    }

    public fun minted_at<T0>(arg0: &Pass<T0>) : u64 {
        arg0.minted_at
    }

    public fun new_first_light_display(arg0: &Service, arg1: &AdminCap, arg2: &mut 0x2::display_registry::DisplayRegistry, arg3: &mut 0x2::tx_context::TxContext) : (0x2::display_registry::Display<FirstLightPass>, 0x2::display_registry::DisplayCap<FirstLightPass>) {
        admin_check(arg0, arg1);
        0x2::display_registry::new<FirstLightPass>(arg2, 0x1::internal::permit<FirstLightPass>(), arg3)
    }

    fun new_pass<T0>(arg0: u8, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Pass<T0> {
        let v0 = Pass<T0>{
            id         : 0x2::object::new(arg6),
            serial     : arg1,
            name       : arg2,
            image_url  : arg3,
            minted_at  : 0x2::clock::timestamp_ms(arg5),
            expires_at : arg4,
        };
        let v1 = PassMinted{
            pass       : 0x2::object::id<Pass<T0>>(&v0),
            tier       : arg0,
            serial     : arg1,
            expires_at : arg4,
        };
        0x2::event::emit<PassMinted>(v1);
        v0
    }

    public fun paused(arg0: &Service) : bool {
        arg0.paused
    }

    public fun publish_record(arg0: &mut Service, arg1: &PublisherCap, arg2: u8, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        publisher_check(arg0, arg1);
        assert!(arg2 < 16, 13906835140712136722);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906835145007235092);
        let v0 = 0x1::vector::length<u8>(&arg5);
        assert!(v0 >= 29 && v0 <= 16384, 13906835153597300758);
        let (v1, v2, v3) = if (0x2::table::contains<u8, Head>(&arg0.heads, arg2)) {
            let v4 = *0x2::table::borrow<u8, Head>(&arg0.heads, arg2);
            assert!(arg3 >= v4.day, 13906835166482333720);
            let v5 = if (arg3 == v4.day) {
                v4.revision + 1
            } else {
                0
            };
            (v5, v4.hash, v4.sequence + 1)
        } else {
            let v6 = b"";
            let v7 = 0;
            while (v7 < 32) {
                0x1::vector::push_back<u8>(&mut v6, 0);
                v7 = v7 + 1;
            };
            (0, v6, 1)
        };
        let v8 = 0x1::hash::sha2_256(arg5);
        let v9 = chain_hash(v2, arg2, arg3, arg4, v8);
        let v10 = Record{
            id           : 0x2::object::new(arg7),
            service      : 0x2::object::id<Service>(arg0),
            stream       : arg2,
            day          : arg3,
            sequence     : v3,
            revision     : v1,
            commitment   : arg4,
            cipher       : arg5,
            cipher_hash  : v8,
            previous     : v2,
            record_hash  : v9,
            published_at : 0x2::clock::timestamp_ms(arg6),
        };
        let v11 = 0x2::object::id<Record>(&v10);
        let v12 = Head{
            record   : v11,
            day      : arg3,
            sequence : v3,
            revision : v1,
            hash     : v9,
        };
        if (0x2::table::contains<u8, Head>(&arg0.heads, arg2)) {
            *0x2::table::borrow_mut<u8, Head>(&mut arg0.heads, arg2) = v12;
        } else {
            0x2::table::add<u8, Head>(&mut arg0.heads, arg2, v12);
        };
        let v13 = RecordKey{
            pos0 : arg2,
            pos1 : arg3,
        };
        if (0x2::dynamic_field::exists<RecordKey>(&arg0.id, v13)) {
            *0x2::dynamic_field::borrow_mut<RecordKey, vector<u8>>(&mut arg0.id, v13) = v9;
        } else {
            0x2::dynamic_field::add<RecordKey, vector<u8>>(&mut arg0.id, v13, v9);
        };
        let v14 = RecordPublished{
            record      : v11,
            stream      : arg2,
            day         : arg3,
            sequence    : v3,
            revision    : v1,
            record_hash : v9,
        };
        0x2::event::emit<RecordPublished>(v14);
        0x2::transfer::freeze_object<Record>(v10);
        v11
    }

    fun publisher_check(arg0: &Service, arg1: &PublisherCap) {
        live_check(arg0);
        assert!(0x2::object::id<PublisherCap>(arg1) == arg0.publisher, 13906835067697561616);
    }

    public fun record_hash_for(arg0: &Service, arg1: u8, arg2: u64) : vector<u8> {
        let v0 = RecordKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        *0x2::dynamic_field::borrow<RecordKey, vector<u8>>(&arg0.id, v0)
    }

    public fun retired_first_light_supply() : u64 {
        10
    }

    public fun return_address(arg0: &Service) : address {
        let v0 = FirstLightKey{dummy_field: false};
        0x2::dynamic_field::borrow<FirstLightKey, FirstLightState>(&arg0.id, v0).return_to
    }

    public fun return_pass(arg0: &Service, arg1: FirstLightPass, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 13906835720532197386);
        let v0 = FirstLightKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<FirstLightKey>(&arg0.id, v0), 13906835724828999718);
        let v1 = FirstLightKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<FirstLightKey, FirstLightState>(&arg0.id, v1).return_to;
        let v3 = FirstLightReturned{
            pass   : 0x2::object::id<FirstLightPass>(&arg1),
            serial : arg1.serial,
            from   : 0x2::tx_context::sender(arg2),
            to     : v2,
        };
        0x2::event::emit<FirstLightReturned>(v3);
        0x2::transfer::transfer<FirstLightPass>(arg1, v2);
    }

    public fun revoke_diversifier(arg0: &mut Service, arg1: &AdminCap, arg2: 0x2::object::ID) {
        admin_check(arg0, arg1);
        let v0 = UnlockKey{pos0: arg2};
        assert!(0x2::dynamic_field::exists<UnlockKey>(&arg0.id, v0), 13906835883742920744);
        let v1 = UnlockKey{pos0: arg2};
        let Unlock {  } = 0x2::dynamic_field::remove<UnlockKey, Unlock>(&mut arg0.id, v1);
        let v2 = DiversifierRevoked{pass: arg2};
        0x2::event::emit<DiversifierRevoked>(v2);
    }

    public fun rotate_admin(arg0: &mut Service, arg1: AdminCap, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        admin_check(arg0, &arg1);
        let AdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg2)};
        arg0.admin = 0x2::object::id<AdminCap>(&v1);
        let v2 = AdminRotated{
            old : 0x2::object::uid_to_inner(&v0),
            new : arg0.admin,
        };
        0x2::event::emit<AdminRotated>(v2);
        v1
    }

    public fun rotate_publisher(arg0: &mut Service, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : PublisherCap {
        admin_check(arg0, arg1);
        let v0 = PublisherCap{id: 0x2::object::new(arg2)};
        arg0.publisher = 0x2::object::id<PublisherCap>(&v0);
        let v1 = PublisherRotated{
            old : arg0.publisher,
            new : arg0.publisher,
        };
        0x2::event::emit<PublisherRotated>(v1);
        v0
    }

    public fun serial<T0>(arg0: &Pass<T0>) : u64 {
        arg0.serial
    }

    public fun set_paused(arg0: &mut Service, arg1: &AdminCap, arg2: bool) {
        admin_check(arg0, arg1);
        arg0.paused = arg2;
        let v0 = PauseChanged{paused: arg2};
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_return_address(arg0: &mut Service, arg1: &AdminCap, arg2: address) {
        admin_check(arg0, arg1);
        let v0 = FirstLightKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FirstLightKey>(&arg0.id, v0)) {
            let v1 = FirstLightKey{dummy_field: false};
            let v2 = FirstLightState{
                minted    : 0,
                return_to : arg2,
            };
            0x2::dynamic_field::add<FirstLightKey, FirstLightState>(&mut arg0.id, v1, v2);
        } else {
            let v3 = FirstLightKey{dummy_field: false};
            0x2::dynamic_field::borrow_mut<FirstLightKey, FirstLightState>(&mut arg0.id, v3).return_to = arg2;
        };
        let v4 = ReturnAddressSet{to: arg2};
        0x2::event::emit<ReturnAddressSet>(v4);
    }

    public fun version(arg0: &Service) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

