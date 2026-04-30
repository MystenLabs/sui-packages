module 0xc2526368317a60be3d9e0c90deb9ecfd82278d7781b291c28ce7b02693b697ff::cumulo {
    struct Cumulo has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        walrus_blob_id: vector<u8>,
        storm_salt: vector<u8>,
        bolts: 0x2::table::Table<vector<u8>, Bolt>,
        epoch: u64,
        version: u64,
    }

    struct Bolt has drop, store {
        encrypted_aes_key: vector<u8>,
        lit_at_ms: u64,
    }

    struct CumuloOpened has copy, drop {
        cumulo: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct BoltLit has copy, drop {
        cumulo: 0x2::object::ID,
        recipient_id: vector<u8>,
        epoch: u64,
    }

    struct BoltDarkened has copy, drop {
        cumulo: 0x2::object::ID,
        recipient_id: vector<u8>,
        epoch: u64,
    }

    struct StormSaltRotated has copy, drop {
        cumulo: 0x2::object::ID,
        new_epoch: u64,
    }

    struct WalrusBlobRotated has copy, drop {
        cumulo: 0x2::object::ID,
        new_blob_id: vector<u8>,
        new_epoch: u64,
    }

    struct ThunderPosted has copy, drop {
        cumulo: 0x2::object::ID,
        sender: address,
        slot: u64,
        epoch: u64,
    }

    public fun bolt_aes_key(arg0: &Cumulo, arg1: vector<u8>) : &vector<u8> {
        &0x2::table::borrow<vector<u8>, Bolt>(&arg0.bolts, arg1).encrypted_aes_key
    }

    public fun bolt_lit_at_ms(arg0: &Cumulo, arg1: vector<u8>) : u64 {
        0x2::table::borrow<vector<u8>, Bolt>(&arg0.bolts, arg1).lit_at_ms
    }

    public fun creator(arg0: &Cumulo) : address {
        arg0.creator
    }

    public fun epoch(arg0: &Cumulo) : u64 {
        arg0.epoch
    }

    public fun go_dark(arg0: &mut Cumulo, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        assert!(0x2::table::contains<vector<u8>, Bolt>(&arg0.bolts, arg1), 2);
        0x2::table::remove<vector<u8>, Bolt>(&mut arg0.bolts, arg1);
        let v0 = BoltDarkened{
            cumulo       : 0x2::object::id<Cumulo>(arg0),
            recipient_id : arg1,
            epoch        : arg0.epoch,
        };
        0x2::event::emit<BoltDarkened>(v0);
    }

    public fun has_bolt(arg0: &Cumulo, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, Bolt>(&arg0.bolts, arg1)
    }

    public fun light_bolt(arg0: &mut Cumulo, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        assert!(!0x2::table::contains<vector<u8>, Bolt>(&arg0.bolts, arg1), 1);
        let v0 = Bolt{
            encrypted_aes_key : arg2,
            lit_at_ms         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<vector<u8>, Bolt>(&mut arg0.bolts, arg1, v0);
        let v1 = BoltLit{
            cumulo       : 0x2::object::id<Cumulo>(arg0),
            recipient_id : arg1,
            epoch        : arg0.epoch,
        };
        0x2::event::emit<BoltLit>(v1);
    }

    public fun n_bolts(arg0: &Cumulo) : u64 {
        0x2::table::length<vector<u8>, Bolt>(&arg0.bolts)
    }

    public fun name(arg0: &Cumulo) : &0x1::string::String {
        &arg0.name
    }

    public fun open(arg0: 0x1::string::String, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : Cumulo {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 >= 1 && v0 <= 64, 5);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Cumulo{
            id             : 0x2::object::new(arg3),
            creator        : v1,
            name           : arg0,
            walrus_blob_id : arg1,
            storm_salt     : arg2,
            bolts          : 0x2::table::new<vector<u8>, Bolt>(arg3),
            epoch          : 0,
            version        : 1,
        };
        let v3 = CumuloOpened{
            cumulo  : 0x2::object::id<Cumulo>(&v2),
            creator : v1,
            name    : v2.name,
        };
        0x2::event::emit<CumuloOpened>(v3);
        v2
    }

    public fun post_thunder(arg0: &Cumulo, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = ThunderPosted{
            cumulo : 0x2::object::id<Cumulo>(arg0),
            sender : 0x2::tx_context::sender(arg2),
            slot   : arg1,
            epoch  : arg0.epoch,
        };
        0x2::event::emit<ThunderPosted>(v0);
    }

    public fun rotate_blob(arg0: &mut Cumulo, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 >= 1 && v0 <= 64, 5);
        arg0.walrus_blob_id = arg1;
        arg0.epoch = arg0.epoch + 1;
        let v1 = WalrusBlobRotated{
            cumulo      : 0x2::object::id<Cumulo>(arg0),
            new_blob_id : arg0.walrus_blob_id,
            new_epoch   : arg0.epoch,
        };
        0x2::event::emit<WalrusBlobRotated>(v1);
    }

    public fun rotate_salt(arg0: &mut Cumulo, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 3);
        arg0.storm_salt = arg1;
        arg0.epoch = arg0.epoch + 1;
        let v0 = StormSaltRotated{
            cumulo    : 0x2::object::id<Cumulo>(arg0),
            new_epoch : arg0.epoch,
        };
        0x2::event::emit<StormSaltRotated>(v0);
    }

    public fun storm_salt(arg0: &Cumulo) : &vector<u8> {
        &arg0.storm_salt
    }

    public fun walrus_blob_id(arg0: &Cumulo) : &vector<u8> {
        &arg0.walrus_blob_id
    }

    // decompiled from Move bytecode v7
}

