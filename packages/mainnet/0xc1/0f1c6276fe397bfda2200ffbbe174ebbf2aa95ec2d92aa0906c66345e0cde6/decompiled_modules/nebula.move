module 0xc10f1c6276fe397bfda2200ffbbe174ebbf2aa95ec2d92aa0906c66345e0cde6::nebula {
    struct Nebula has store, key {
        id: 0x2::object::UID,
        owner: address,
        suins_name: 0x1::string::String,
        ek_compressed: vector<u8>,
        committee_ref: vector<u8>,
        ell_max: u64,
        epoch_padding: u64,
        current_epoch: u64,
        version: u64,
    }

    struct NebulaEpoch has store, key {
        id: 0x2::object::UID,
        inbox: 0x2::object::ID,
        epoch_no: u64,
        cts: vector<vector<u8>>,
        aead_payloads: vector<vector<u8>>,
        senders: vector<address>,
        walrus_blob_ids: vector<vector<u8>>,
        bad_ct_indices: 0x2::vec_set::VecSet<u64>,
        sbk: vector<u8>,
        sealed_at_ms: u64,
    }

    struct NebulaOpened has copy, drop {
        inbox: 0x2::object::ID,
        owner: address,
        ell_max: u64,
        epoch_padding: u64,
    }

    struct ThunderPosted has copy, drop {
        epoch: 0x2::object::ID,
        inbox: 0x2::object::ID,
        epoch_no: u64,
        slot: u64,
        sender: address,
    }

    struct NebulaEpochSealed has copy, drop {
        epoch: 0x2::object::ID,
        inbox: 0x2::object::ID,
        epoch_no: u64,
        sealed_at_ms: u64,
        n_messages: u64,
    }

    struct NebulaEpochRotated has copy, drop {
        inbox: 0x2::object::ID,
        prev_epoch: 0x2::object::ID,
        new_epoch: 0x2::object::ID,
        new_epoch_no: u64,
    }

    struct CtMarkedBad has copy, drop {
        epoch: 0x2::object::ID,
        slot: u64,
        flagged_sender: address,
    }

    public fun current_epoch_no(arg0: &Nebula) : u64 {
        arg0.current_epoch
    }

    public fun ek(arg0: &Nebula) : &vector<u8> {
        &arg0.ek_compressed
    }

    public fun ell_max(arg0: &Nebula) : u64 {
        arg0.ell_max
    }

    public fun epoch_bad_indices(arg0: &NebulaEpoch) : &0x2::vec_set::VecSet<u64> {
        &arg0.bad_ct_indices
    }

    public fun epoch_cts(arg0: &NebulaEpoch) : &vector<vector<u8>> {
        &arg0.cts
    }

    public fun epoch_inbox(arg0: &NebulaEpoch) : 0x2::object::ID {
        arg0.inbox
    }

    public fun epoch_is_sealed(arg0: &NebulaEpoch) : bool {
        arg0.sealed_at_ms != 0
    }

    public fun epoch_no(arg0: &NebulaEpoch) : u64 {
        arg0.epoch_no
    }

    public fun epoch_padding(arg0: &Nebula) : u64 {
        arg0.epoch_padding
    }

    public fun epoch_payloads(arg0: &NebulaEpoch) : &vector<vector<u8>> {
        &arg0.aead_payloads
    }

    public fun epoch_sbk(arg0: &NebulaEpoch) : &vector<u8> {
        &arg0.sbk
    }

    public fun epoch_sealed_at_ms(arg0: &NebulaEpoch) : u64 {
        arg0.sealed_at_ms
    }

    public fun epoch_senders(arg0: &NebulaEpoch) : &vector<address> {
        &arg0.senders
    }

    public fun epoch_walrus_blobs(arg0: &NebulaEpoch) : &vector<vector<u8>> {
        &arg0.walrus_blob_ids
    }

    fun is_power_of_two(arg0: u64) : bool {
        arg0 > 0 && arg0 & arg0 - 1 == 0
    }

    public fun mark_bad_ct(arg0: &mut NebulaEpoch, arg1: &Nebula, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 0);
        assert!(arg0.inbox == 0x2::object::id<Nebula>(arg1), 0);
        assert!(arg0.sealed_at_ms == 0, 9);
        assert!(arg2 < 0x1::vector::length<vector<u8>>(&arg0.cts), 7);
        0x2::vec_set::insert<u64>(&mut arg0.bad_ct_indices, arg2);
        let v0 = CtMarkedBad{
            epoch          : 0x2::object::id<NebulaEpoch>(arg0),
            slot           : arg2,
            flagged_sender : *0x1::vector::borrow<address>(&arg0.senders, arg2),
        };
        0x2::event::emit<CtMarkedBad>(v0);
    }

    fun new_epoch(arg0: &Nebula, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : NebulaEpoch {
        NebulaEpoch{
            id              : 0x2::object::new(arg2),
            inbox           : 0x2::object::id<Nebula>(arg0),
            epoch_no        : arg1,
            cts             : vector[],
            aead_payloads   : vector[],
            senders         : vector[],
            walrus_blob_ids : vector[],
            bad_ct_indices  : 0x2::vec_set::empty<u64>(),
            sbk             : b"",
            sealed_at_ms    : 0,
        }
    }

    public fun open(arg0: 0x1::string::String, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Nebula {
        assert!(0x1::vector::length<u8>(&arg1) == 576, 2);
        assert!(is_power_of_two(arg3), 4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Nebula{
            id            : 0x2::object::new(arg5),
            owner         : v0,
            suins_name    : arg0,
            ek_compressed : arg1,
            committee_ref : arg2,
            ell_max       : arg3,
            epoch_padding : arg4,
            current_epoch : 0,
            version       : 1,
        };
        let v2 = NebulaOpened{
            inbox         : 0x2::object::id<Nebula>(&v1),
            owner         : v0,
            ell_max       : arg3,
            epoch_padding : arg4,
        };
        0x2::event::emit<NebulaOpened>(v2);
        v1
    }

    public fun owner(arg0: &Nebula) : address {
        arg0.owner
    }

    public fun post_thunder(arg0: &mut NebulaEpoch, arg1: &Nebula, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.inbox == 0x2::object::id<Nebula>(arg1), 0);
        assert!(arg0.sealed_at_ms == 0, 6);
        assert!(0x1::vector::length<u8>(&arg2) == 704, 1);
        let v0 = 0x1::vector::length<vector<u8>>(&arg0.cts);
        assert!(v0 < arg1.ell_max, 5);
        let v1 = 0x2::tx_context::sender(arg5);
        0x1::vector::push_back<vector<u8>>(&mut arg0.cts, arg2);
        0x1::vector::push_back<vector<u8>>(&mut arg0.aead_payloads, arg3);
        0x1::vector::push_back<address>(&mut arg0.senders, v1);
        0x1::vector::push_back<vector<u8>>(&mut arg0.walrus_blob_ids, arg4);
        let v2 = ThunderPosted{
            epoch    : 0x2::object::id<NebulaEpoch>(arg0),
            inbox    : 0x2::object::id<Nebula>(arg1),
            epoch_no : arg0.epoch_no,
            slot     : v0,
            sender   : v1,
        };
        0x2::event::emit<ThunderPosted>(v2);
    }

    public fun rotate_epoch(arg0: &mut Nebula, arg1: &NebulaEpoch, arg2: &mut 0x2::tx_context::TxContext) : NebulaEpoch {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg1.inbox == 0x2::object::id<Nebula>(arg0), 0);
        assert!(arg1.sealed_at_ms != 0, 8);
        arg0.current_epoch = arg0.current_epoch + 1;
        let v0 = new_epoch(arg0, arg0.current_epoch, arg2);
        let v1 = NebulaEpochRotated{
            inbox        : 0x2::object::id<Nebula>(arg0),
            prev_epoch   : 0x2::object::id<NebulaEpoch>(arg1),
            new_epoch    : 0x2::object::id<NebulaEpoch>(&v0),
            new_epoch_no : arg0.current_epoch,
        };
        0x2::event::emit<NebulaEpochRotated>(v1);
        v0
    }

    public fun seal_epoch(arg0: &mut NebulaEpoch, arg1: &Nebula, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 0);
        assert!(arg0.inbox == 0x2::object::id<Nebula>(arg1), 0);
        assert!(arg0.sealed_at_ms == 0, 6);
        assert!(0x1::vector::length<u8>(&arg2) == 48, 3);
        arg0.sbk = arg2;
        arg0.sealed_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = NebulaEpochSealed{
            epoch        : 0x2::object::id<NebulaEpoch>(arg0),
            inbox        : 0x2::object::id<Nebula>(arg1),
            epoch_no     : arg0.epoch_no,
            sealed_at_ms : arg0.sealed_at_ms,
            n_messages   : 0x1::vector::length<vector<u8>>(&arg0.cts),
        };
        0x2::event::emit<NebulaEpochSealed>(v0);
    }

    public fun set_epoch_padding(arg0: &mut Nebula, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.epoch_padding = arg1;
    }

    // decompiled from Move bytecode v7
}

