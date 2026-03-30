module 0xca0126a4acf52388d63f1ef53347121bdce34da2e90851b581b463a0d5e99f68::sibyl {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Sibyl has key {
        id: 0x2::object::UID,
        pythia: address,
        offering: u64,
        stale_threshold: u64,
        cache: address,
        chronicom_count: u64,
    }

    struct Chronicom has store, key {
        id: 0x2::object::UID,
        role: u8,
        name: vector<u8>,
        operator: address,
        created_at: u64,
        metadata: 0x2::vec_map::VecMap<vector<u8>, vector<u8>>,
    }

    struct Timestream has store, key {
        id: 0x2::object::UID,
        feed_id: vector<u8>,
        price: I64,
        confidence: u64,
        expo: I64,
        timestamp: u64,
        ema_price: I64,
        ema_confidence: u64,
    }

    struct I64 has copy, drop, store {
        magnitude: u64,
        negative: bool,
    }

    struct TimestreamCreated has copy, drop {
        feed_id: vector<u8>,
        timestream_id: address,
    }

    struct VisionChanneled has copy, drop {
        feed_id: vector<u8>,
        price: u64,
        negative: bool,
        confidence: u64,
        timestamp: u64,
    }

    struct ChronicomCreated has copy, drop {
        chronicom_id: address,
        role: u8,
        name: vector<u8>,
        operator: address,
    }

    public fun channel_vision(arg0: &Sibyl, arg1: &mut Timestream, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg12) == arg0.pythia, 0);
        assert!(arg7 <= 0x2::clock::timestamp_ms(arg11) / 1000 + 10, 2);
        let v0 = I64{
            magnitude : arg2,
            negative  : arg3,
        };
        arg1.price = v0;
        arg1.confidence = arg4;
        let v1 = I64{
            magnitude : arg5,
            negative  : arg6,
        };
        arg1.expo = v1;
        arg1.timestamp = arg7;
        let v2 = I64{
            magnitude : arg8,
            negative  : arg9,
        };
        arg1.ema_price = v2;
        arg1.ema_confidence = arg10;
        let v3 = VisionChanneled{
            feed_id    : arg1.feed_id,
            price      : arg2,
            negative   : arg3,
            confidence : arg4,
            timestamp  : arg7,
        };
        0x2::event::emit<VisionChanneled>(v3);
    }

    public fun chronicom_name(arg0: &Chronicom) : vector<u8> {
        arg0.name
    }

    public fun chronicom_operator(arg0: &Chronicom) : address {
        arg0.operator
    }

    public fun chronicom_role(arg0: &Chronicom) : u8 {
        arg0.role
    }

    public fun create_timestream(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = I64{
            magnitude : 0,
            negative  : true,
        };
        let v1 = Timestream{
            id             : 0x2::object::new(arg2),
            feed_id        : arg1,
            price          : i64_zero(),
            confidence     : 0,
            expo           : v0,
            timestamp      : 0,
            ema_price      : i64_zero(),
            ema_confidence : 0,
        };
        let v2 = TimestreamCreated{
            feed_id       : arg1,
            timestream_id : 0x2::object::id_address<Timestream>(&v1),
        };
        0x2::event::emit<TimestreamCreated>(v2);
        0x2::transfer::share_object<Timestream>(v1);
    }

    public fun i64_value(arg0: &I64) : (u64, bool) {
        (arg0.magnitude, arg0.negative)
    }

    fun i64_zero() : I64 {
        I64{
            magnitude : 0,
            negative  : false,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Sibyl{
            id              : 0x2::object::new(arg0),
            pythia          : 0x2::tx_context::sender(arg0),
            offering        : 1,
            stale_threshold : 60,
            cache           : 0x2::tx_context::sender(arg0),
            chronicom_count : 0,
        };
        0x2::transfer::share_object<Sibyl>(v1);
    }

    public fun prophecy(arg0: &Sibyl, arg1: &Timestream, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock) : (u64, bool, u64, u64, bool, u64) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0.offering, 3);
        assert!(arg1.timestamp > 0 && 0x2::clock::timestamp_ms(arg3) / 1000 - arg1.timestamp <= arg0.stale_threshold, 2);
        (arg1.price.magnitude, arg1.price.negative, arg1.confidence, arg1.expo.magnitude, arg1.expo.negative, arg1.timestamp)
    }

    public fun prophecy_no_older_than(arg0: &Timestream, arg1: &0x2::clock::Clock, arg2: u64) : (u64, bool, u64, u64, bool, u64) {
        assert!(arg0.timestamp > 0 && 0x2::clock::timestamp_ms(arg1) / 1000 - arg0.timestamp <= arg2, 2);
        (arg0.price.magnitude, arg0.price.negative, arg0.confidence, arg0.expo.magnitude, arg0.expo.negative, arg0.timestamp)
    }

    public fun prophecy_unsafe(arg0: &Timestream) : (u64, bool, u64, u64, bool, u64) {
        (arg0.price.magnitude, arg0.price.negative, arg0.confidence, arg0.expo.magnitude, arg0.expo.negative, arg0.timestamp)
    }

    public fun set_cache(arg0: &AdminCap, arg1: &mut Sibyl, arg2: address) {
        arg1.cache = arg2;
    }

    public fun set_chronicom_metadata(arg0: &AdminCap, arg1: &mut Chronicom, arg2: vector<u8>, arg3: vector<u8>) {
        if (0x2::vec_map::contains<vector<u8>, vector<u8>>(&arg1.metadata, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<vector<u8>, vector<u8>>(&mut arg1.metadata, &arg2);
        };
        0x2::vec_map::insert<vector<u8>, vector<u8>>(&mut arg1.metadata, arg2, arg3);
    }

    public fun set_offering(arg0: &AdminCap, arg1: &mut Sibyl, arg2: u64) {
        arg1.offering = arg2;
    }

    public fun set_pythia(arg0: &AdminCap, arg1: &mut Sibyl, arg2: address) {
        arg1.pythia = arg2;
    }

    public fun set_stale_threshold(arg0: &AdminCap, arg1: &mut Sibyl, arg2: u64) {
        arg1.stale_threshold = arg2;
    }

    public fun summon_chronicom(arg0: &AdminCap, arg1: &mut Sibyl, arg2: u8, arg3: vector<u8>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Chronicom {
        arg1.chronicom_count = arg1.chronicom_count + 1;
        let v0 = Chronicom{
            id         : 0x2::object::new(arg6),
            role       : arg2,
            name       : arg3,
            operator   : arg4,
            created_at : 0x2::clock::timestamp_ms(arg5),
            metadata   : 0x2::vec_map::empty<vector<u8>, vector<u8>>(),
        };
        let v1 = ChronicomCreated{
            chronicom_id : 0x2::object::id_address<Chronicom>(&v0),
            role         : arg2,
            name         : v0.name,
            operator     : arg4,
        };
        0x2::event::emit<ChronicomCreated>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

